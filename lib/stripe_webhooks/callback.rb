module StripeWebhooks
  class Callback

    @callbacks = []

    module ClassMethods
      attr_reader :callbacks, :event_types

      # Add a callback to be ran whenever a new event is recorded
      #
      # === Example
      #
      #  StripeWebhooks::Callback.register_callback('my_callback')
      # 
      def register_callback(label)
        @callbacks << label
      end

      # Run callbacks for a given event type
      #
      # === Example
      #
      #  StripeWebhooks::Callback.run_callbacks_for('customer.subscription.deleted', stripe_event)
      #
      def run_callbacks_for(event_type, event)
        @callbacks.each do |label|
          class_name = "#{label.classify}Callback"
          callback = class_name.constantize.new(label)
          if callback.handles?(event_type)
            callback.run(event)
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

    attr_reader :label

    def initialize(label)
      @label = label
    end

    # Return true if the Callback handles this type of event
    #
    def handles?(event_type)
      return self.class.event_types.include?(event_type)
    end

  end
end