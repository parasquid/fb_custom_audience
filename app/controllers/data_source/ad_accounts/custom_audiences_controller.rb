class DataSource::AdAccounts::CustomAudiencesController < ApplicationController
  layout false

  def index
    custom_audiences = graph.get_connections("act_226287978", "customaudiences",
      fields: [:name, :description, :approximate_count, :operation_status, :delivery_status]
    )
    @results = custom_audiences.map { |data|
      id = data["id"]
      lut = CustomAudienceToWorkflowLut.where(custom_audience_id: id).first
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
    byebug
  end

  private

  def graph
    token = current_user.token
    graph = Koala::Facebook::API.new(token)
  end
end
