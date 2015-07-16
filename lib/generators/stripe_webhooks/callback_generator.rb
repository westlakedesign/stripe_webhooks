require 'generators/stripe_webhooks'

module StripeWebhooks
  module Generators
    class CallbackGenerator < Base
      desc "Creates a stripe webhook callback object"
      argument :event_types, :type => :array, :default => [], :banner => 'event.type.a event.type.b ...'

      source_root File.expand_path('../templates', __FILE__)

      def create_callback
        application_callback = 'app/callbacks/application_callback.rb'
        if !File.exist?(application_callback)
          template 'application_callback.rb.erb', application_callback
        end

        template 'callback.rb.erb', "app/callbacks/#{name.underscore}_callback.rb"
        
        initializer = 'config/initializers/stripe_webhook_callbacks.rb'
        if !File.exist?(initializer)
          create_file(initializer)
        end
        append_to_file initializer, "StripeWebhooks::Callback.register_callback('#{name.underscore}')\n"
      end

    end
  end
end
