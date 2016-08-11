FactoryGirl.define do
  factory :stripe_webhooks_performed_callback, class: 'StripeWebhooks::PerformedCallback' do
    stripe_event_id 'MyString'
    label 'MyString'
  end
end
