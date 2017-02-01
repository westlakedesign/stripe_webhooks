# This migration comes from stripe_webhooks (originally 20170201175643)
class AddUserIdToStripeWebhookEvents < ActiveRecord::Migration[5.0]
  def change
    change_table :stripe_webhooks_events do |t|
      t.string :user_id
      t.boolean :livemode, default: false
    end
  end
end
