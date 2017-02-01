require 'generators/stripe_webhooks'

module StripeWebhooks
  module Generators
    class CallbackGenerator < Base
      desc 'Creates a stripe webhook callback object'
      argument :event_types, type: :array, default: [], banner: 'event.type.a event.type.b ...'

      source_root File.expand_path('../templates', __FILE__)

      def create_callback
        application_callback = 'app/callbacks/application_callback.rb'
        unless File.exist?(application_callback)
          template 'application_callback.rb.erb', application_callback
        end
        template 'callback.rb.erb', "app/callbacks/#{name.underscore}_callback.rb"

        if defined?(RSpec) && Dir.exist?(Rails.root.join('spec'))
          template 'callback_spec.rb.erb',
            Rails.root.join('spec', 'callbacks', "#{name.underscore}_callback_spec.rb")
        end
      end

    end
  end
end
