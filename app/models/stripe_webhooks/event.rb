module StripeWebhooks
  class Event < ActiveRecord::Base
    validates :stripe_event_id, :presence => true, :uniqueness => true

    def stripe_event
      @_stripe_event ||= Stripe::Event.retrieve(stripe_event_id)
      return @_stripe_event
    end

    def process!
      begin
        event = stripe_event()
        update_attributes({
          :is_processed => true,
          :is_authentic => true,
          :stripe_event_type => event.type,
          :stripe_created_at => Time.at(event.created).to_datetime
        })
      rescue Stripe::InvalidRequestError
        update_attributes(:is_processed => true, :is_authentic => false)
      end
    end

  end
end
