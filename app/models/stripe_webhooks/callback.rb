module StripeWebhooks
  class Callback

    module ClassMethods
      attr_reader :event_types

      # Run callbacks for a given event type
      #
      # === Example
      #
      #  StripeWebhooks::Callback.run_callbacks_for('customer.subscription.deleted', stripe_event)
      #
      def run_callbacks_for(event_type, event)
        StripeWebhooks.callbacks.each do |label|
          class_name = "#{label.classify}Callback"
          callback = class_name.constantize.new
          if callback.handles?(event_type)
            callback.run_once(event)
          end
        end
      end

      # Declares which event types a callback will handle
      #
      # === Example
      #
      #   class MyCallback < StripeWebhooks::Callback
      #     handles_events 'customer.subscription.deleted', 'customer.subscription.testing'
      #     def run(event)
      #       puts "Do useful stuff"
      #     end
      #   end
      #
      def handles_events(*event_types)
        @event_types = event_types
      end
    end
    extend ClassMethods

    # Return the label for the callback. Label is based on the class name.
    #
    def label
      return self.class.to_s.underscore.gsub('_callback', '')
    end

    # Run the callback only if we have not run it once before
    #
    def run_once(event)
      if !StripeWebhooks::PerformedCallback.exists?(:stripe_event_id => event.id, :label => label)
        run(event)
        StripeWebhooks::PerformedCallback.create(:stripe_event_id => event.id, :label => label)
      end
    end

    # Return true if the Callback handles this type of event
    #
    def handles?(event_type)
      return self.class.event_types.include?(event_type)
    end

  end
end
