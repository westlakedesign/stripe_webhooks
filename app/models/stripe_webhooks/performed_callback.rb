module StripeWebhooks
  class PerformedCallback < ActiveRecord::Base
    belongs_to :event, primary_key: :stripe_event_id, foreign_key: :stripe_event_id
  end
end
