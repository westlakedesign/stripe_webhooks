# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150716195741) do

  create_table "stripe_webhooks_events", force: :cascade do |t|
    t.string   "stripe_event_id",   limit: 255
    t.string   "stripe_event_type", limit: 255
    t.datetime "stripe_created_at"
    t.boolean  "is_processed",                  default: false
    t.boolean  "is_authentic",                  default: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "stripe_webhooks_events", ["stripe_event_id"], name: "index_stripe_webhooks_events_on_stripe_event_id", unique: true, using: :btree

  create_table "stripe_webhooks_performed_callbacks", force: :cascade do |t|
    t.string   "stripe_event_id", limit: 255, null: false
    t.string   "label",           limit: 255, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "stripe_webhooks_performed_callbacks", ["stripe_event_id", "label"], name: "index_stripe_webhooks_performed_callbacks_event_id_label", using: :btree

end
