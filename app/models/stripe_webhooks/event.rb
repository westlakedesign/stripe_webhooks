module StripeWebhooks
  class Event < ActiveRecord::Base
    validates :stripe_event_id, :presence => true, :uniqueness => true
  end
end
