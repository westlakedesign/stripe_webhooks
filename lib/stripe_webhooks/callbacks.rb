module StripeWebhooks
  module Callbacks
    def self.included(base)
      base.instance_variable_set(:@callbacks, [])
      base.extend ClassMethods
    end

    module ClassMethods
      attr_reader :callbacks

      # Add a callback to be ran whenever a new event is recorded
      #
      # === Example
      #
      #  StripeWebhooks.register_callback('my_callback')
      #
      def register_callback(label)
        @callbacks << label unless @callbacks.include?(label) || label == 'application'
      end
    end
  end
end
