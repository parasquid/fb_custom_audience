class ProcessMaropostJourneyJob < ApplicationJob
  def perform(params)
    LOGGER.info params
  end
end
