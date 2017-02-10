class ProcessMaropostJourneyJob < ApplicationJob
  def perform(params)
    workflow_id = params["workflow_id"]
    custom_audience_id = Workflow.where(mp_id: workflow_id).first.custom_audience_id
    email = aprams["contact"]["email"]
    payload = {
      schema: "EMAIL_SHA256",
      data: [Digest::SHA256.hexdigest(email)]
    }
    result = graph.put_connections(custom_audience_id, "users", payload:payload.to_json)
    LOGGER.info result
  end
end
