module StripeWebhooks
  class Callback

    @@callbacks = []

    # Add a callback to be ran whenever a new event is recorded
    #
    # === Example
    #
    #  StripeWebhooks::Callback.register_callback('my_callback', 'customer.subscription.deleted', 'customer.subscription.created') do |event|
    #    ... do something useful with the event here
    #  end
    # 
    def self.register_callback(label, *event_types, &block)
      @@callbacks << new(label, event_types, block)
    end

    def self.run_callbacks_for(event_type, event)
      @@callbacks.each do |callback|
        if callback.handles?(event_type)
          callback.run(event)
        end
      end
    end

    attr_reader :label, :event_types, :block

    def initialize(label, event_types, block)
      @label = label
      @event_types = event_types
      @block = block
    end

    def handles?(event_type)
      return @event_types.include?(event_type)
    end

    def run(event)
      @block.call(event)
    end

  end
end
