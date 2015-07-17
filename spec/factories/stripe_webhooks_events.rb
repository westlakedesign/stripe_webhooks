FactoryGirl.define do
  factory :stripe_webhooks_event, :class => 'StripeWebhooks::Event' do
    stripe_event_id "evt_00000000000000"
    stripe_event_type "charge.succeeded"
    stripe_created_at DateTime.now()
    is_processed true
    is_authentic true
  end
end
