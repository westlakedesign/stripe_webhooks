class CreateStripeWebhooksPerformedCallbacks < ActiveRecord::Migration
  def change
    create_table :stripe_webhooks_performed_callbacks do |t|
      t.string :stripe_event_id, :null => false
      t.string :label, :null => false
      t.index [:stripe_event_id, :label], :name => 'index_stripe_webhooks_performed_callbacks_event_id_label'
      t.timestamps null: false
    end
  end
end
