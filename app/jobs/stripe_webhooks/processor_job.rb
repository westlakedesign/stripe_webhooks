module StripeWebhooks
  class ProcessorJob < ActiveJob::Base
    queue_as :default

    def perform(event)
      puts "running!"
      event.validate!
      if event.is_authentic?
        event.run_callbacks!
      end
    end

  end
end
