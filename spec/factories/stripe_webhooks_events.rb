FactoryGirl.define do
  factory :stripe_webhooks_event, :class => 'StripeWebhooks::Event' do
    stripe_event_id "MyString"
stripe_event_type "MyString"
stripe_created_at "2015-07-15 11:29:05"
is_processed false
is_authentic false
  end

end
