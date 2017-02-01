# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170201180822) do

  create_table "stripe_webhooks_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "stripe_event_id"
    t.string   "stripe_event_type"
    t.datetime "stripe_created_at"
    t.boolean  "is_processed",      default: false
    t.boolean  "is_authentic",      default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "user_id"
    t.boolean  "livemode",          default: false
    t.index ["stripe_event_id"], name: "index_stripe_webhooks_events_on_stripe_event_id", unique: true, using: :btree
  end

  create_table "stripe_webhooks_performed_callbacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "stripe_event_id", null: false
    t.string   "label",           null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["stripe_event_id", "label"], name: "index_stripe_webhooks_performed_callbacks_event_id_label", using: :btree
  end

end
