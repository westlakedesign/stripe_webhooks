class CreateStripeWebhooksEvents < ActiveRecord::Migration
  def change
    create_table :stripe_webhooks_events do |t|
      t.string :stripe_event_id
      t.index :stripe_event_id, :unique => true
      t.string :stripe_event_type
      t.datetime :stripe_created_at
      t.boolean :is_processed, :default => false
      t.boolean :is_authentic, :default => false
      t.timestamps null: false
    end
  end
end
