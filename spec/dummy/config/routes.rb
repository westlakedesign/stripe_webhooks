Rails.application.routes.draw do
  mount StripeWebhooks::Engine => '/stripe_webhooks'
end
