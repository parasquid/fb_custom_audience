class DataSource::AdAccounts::CustomAudiencesController < LoggedInController
  layout false

  def show
    @results = []
    begin
      ad_act = params[:id]
      custom_audiences = graph.get_connections(ad_act, "customaudiences",
        fields: [:name, :description, :approximate_count, :operation_status, :delivery_status]
      )
      @results += custom_audiences.map { |data|
        id = data["id"]
        lut = current_user.custom_audiences.where(fb_id: id).first_or_create
        workflow_ids = lut&.workflow_ids || NullObject.get
        {
          id: id,
          ad_act_id: ad_act,
          name: data["name"],
          description: data["description"],
          approximate_count: data["approximate_count"],
          operation_status: data["operation_status"]["description"],
          delivery_status: data["delivery_status"]["description"],
          workflow_ids: workflow_ids
        }
      }
    rescue StandardError => ex
      Rails.logger.info ex
      render text: ex
    end
  end

  def create
    begin
      ad_act_id = params[:custom_audience][:ad_act_id]
      ca_name = params[:custom_audience][:name]
      graph.put_connections(ad_act_id, "customaudiences", name: ca_name, subtype: "CUSTOM")
      redirect_back fallback_location: root_url, notice: "Custom Audience created!"
    rescue StandardError => ex
      Rails.logger.info ex
      render text: ex
    end
  end

  def workflows
    parameters = params[:add_workflow_ids_to_custom_audience]
    workflow_ids = parameters[:workflow_ids].split(",").map(&:strip)
    custom_audience_id = parameters[:custom_audience_id]
    model = current_user.custom_audiences.where(fb_id: custom_audience_id).first
    model.workflows = workflow_ids.map { |id| model.workflows.where(mp_id: id).first_or_create }
    model.save!
    redirect_back fallback_location: root_url, notice: "Workflow IDs saved!"
  end

end
