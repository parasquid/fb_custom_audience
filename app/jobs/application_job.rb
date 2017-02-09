class ApplicationJob < ActiveJob::Base
  LOGGER = Sidekiq.logger
end
