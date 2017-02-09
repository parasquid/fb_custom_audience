class DataSource::AdAccounts::CustomAudiencesController < ApplicationController
  layout false

  def index
    token = current_user.token
    graph = Koala::Facebook::API.new(token)
    custom_audiences = graph.get_connections("act_226287978", "customaudiences",
      fields: [:name, :description, :approximate_count, :operation_status, :delivery_status]
    )
    # binding.pry
    @results = custom_audiences.map { |data|
      {
        name: data["name"],
        description: data["description"],
        approximate_count: data["approximate_count"],
        operation_status: data["operation_status"]["description"],
        delivery_status: data["delivery_status"]["description"]
      }
    }
  end
end
