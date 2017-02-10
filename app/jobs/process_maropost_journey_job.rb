class ProcessMaropostJourneyJob < ApplicationJob
  def perform(params)
    workflow_id = params["workflow_id"]
    custom_audience = Workflow.where(mp_id: workflow_id).first.custom_audience
    custom_audience_id = custom_audience.id
    email = params["contact"]["email"]
    payload = {
      schema: "EMAIL_SHA256",
      data: [Digest::SHA256.hexdigest(email)]
    }

    current_user = custom_audience.user
    token = current_user.token
    graph = Koala::Facebook::API.new(token)

    result = graph.put_connections(custom_audience_id, "users", payload:payload.to_json)
    LOGGER.info result
  end

end
