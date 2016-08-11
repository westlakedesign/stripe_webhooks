require 'stripe_webhooks/engine'
require 'stripe_webhooks/callbacks'

module StripeWebhooks
  include Callbacks
end
