module StripeWebhooks
  class ProcessorJob < ActiveJob::Base
    queue_as :default

    def perform(event)
      event.validate!
      event.run_callbacks! if event.is_authentic?
    end

  end
end
