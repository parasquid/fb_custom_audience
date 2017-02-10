class DataSource::AdAccounts::CustomAudiencesController < ApplicationController
  layout false

  def index
    custom_audiences = graph.get_connections("act_226287978", "customaudiences",
      fields: [:name, :description, :approximate_count, :operation_status, :delivery_status]
    )
    @results = custom_audiences.map { |data|
      id = data["id"]
      lut = CustomAudience.where(fb_id: id).first_or_create
      workflow_ids = lut&.workflow_ids || NullObject.get
      {
        id: id,
        name: data["name"],
        description: data["description"],
        approximate_count: data["approximate_count"],
        operation_status: data["operation_status"]["description"],
        delivery_status: data["delivery_status"]["description"],
        workflow_ids: workflow_ids
      }
    }
  end

  def workflows
    parameters = params[:add_workflow_ids_to_custom_audience]
    workflow_ids = parameters[:workflow_ids].split(",").map(&:strip)
    custom_audience_id = parameters[:custom_audience_id]
    model = CustomAudience.where(fb_id: custom_audience_id).first
    model.workflows = workflow_ids.map { |id| model.workflows.where(mp_id: id).first_or_create }
    model.save!
    redirect_back fallback_location: root_url, notice: "Workflow IDs saved!"
  end

  private

  def graph
    token = current_user.token
    graph = Koala::Facebook::API.new(token)
  end
end
