module StripeWebhooks
  class Event < ActiveRecord::Base
    validates :stripe_event_id, :presence => true, :uniqueness => true
    has_many :performed_callbacks, :primary_key => :stripe_event_id, :foreign_key => :stripe_event_id

    def stripe_event
      if created_at < 30.days.ago
        Rails.logger.warn('The event you requested was created over 30 days ago, which means it may no longer be available via the Stripe Events API.')
      end
      @_stripe_event ||= Stripe::Event.retrieve(stripe_event_id)
      return @_stripe_event
    end

    def validate!
      return true if is_authentic
      begin
        event = stripe_event()
        update_attributes({
          :is_processed => true,
          :is_authentic => true,
          :stripe_event_type => event.type,
          :stripe_created_at => Time.at(event.created).to_datetime
        })
        return true
      rescue Stripe::InvalidRequestError
        update_attributes(:is_processed => true, :is_authentic => false)
        return false
      end
    end

    def run_callbacks!
      StripeWebhooks::Callback.run_callbacks_for(self.stripe_event_type, self.stripe_event)
      return true
    end

  end
end
