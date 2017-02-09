class Api::MaropostController < Api::ApiController
  def update
    ProcessMaropostJourneyJob.perform_later(params.to_unsafe_h)
    head :ok
  end
end
