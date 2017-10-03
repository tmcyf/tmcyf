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

ActiveRecord::Schema.define(version: 20161107022026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charges", force: :cascade do |t|
    t.string  "stripe_id",  limit: 255
    t.string  "last4",      limit: 255
    t.decimal "amount"
    t.integer "user_id"
    t.integer "payment_id"
    t.boolean "offline"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "location"
    t.string   "image",      limit: 255
    t.text     "body"
    t.string   "slug",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "startdt"
    t.datetime "enddt"
  end

  add_index "events", ["slug"], name: "index_events_on_slug", using: :btree

  create_table "featured_events", force: :cascade do |t|
    t.string   "image_url",  limit: 255
    t.string   "event_url",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "odr_registrations", force: :cascade do |t|
    t.string  "email",          limit: 255
    t.string  "fname",          limit: 255
    t.string  "lname",          limit: 255
    t.string  "parish",         limit: 255
    t.integer "age"
    t.string  "shirt_size",     limit: 255
    t.string  "payment_method", limit: 255
    t.text    "diet"
  end

  create_table "pages", force: :cascade do |t|
  end

  create_table "payments", force: :cascade do |t|
    t.integer "amount"
    t.string  "description",  limit: 255
    t.integer "payable_id"
    t.string  "payable_type", limit: 255
    t.boolean "active"
  end

  create_table "retreats", force: :cascade do |t|
    t.string   "fname",                      limit: 255
    t.string   "lname",                      limit: 255
    t.string   "email",                      limit: 255
    t.string   "line1",                      limit: 255
    t.string   "city",                       limit: 255
    t.string   "state",                      limit: 255
    t.string   "zip",                        limit: 255
    t.string   "phone",                      limit: 255
    t.string   "gender",                     limit: 255
    t.date     "birthday"
    t.string   "shirt_size",                 limit: 255
    t.string   "emergency_contact",          limit: 255
    t.string   "emergency_contact_relation", limit: 255
    t.string   "emergency_contact_number",   limit: 255
    t.string   "insurance_provider",         limit: 255
    t.string   "insurance_policy_number",    limit: 255
    t.text     "allergy_information"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "transportation",             limit: 255
    t.boolean  "policy_confirmation",                    default: false
    t.string   "payment_method",             limit: 255
  end

  create_table "sermons", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "notes"
    t.string   "audio",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "authentication_token",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fname",                  limit: 255
    t.string   "lname",                  limit: 255
    t.string   "phone",                  limit: 255
    t.string   "gender",                 limit: 255
    t.date     "birthday"
    t.string   "line1",                  limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "zip",                    limit: 255
    t.string   "shirtsize",              limit: 255
    t.boolean  "email_contact",                      default: false
    t.boolean  "facebook_contact",                   default: false
    t.boolean  "sms_contact",                        default: false
    t.boolean  "admin",                              default: false
    t.string   "stripe_id",              limit: 255
    t.string   "current_last4",          limit: 255
    t.integer  "status",                             default: 0
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "womens_retreat_registrations", force: :cascade do |t|
    t.string   "fname",                   limit: 255
    t.string   "lname",                   limit: 255
    t.date     "birthday"
    t.string   "address",                 limit: 255
    t.string   "phone",                   limit: 255
    t.integer  "age"
    t.string   "academic_classification", limit: 255
    t.string   "parish",                  limit: 255
    t.boolean  "accommodations"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "restrictions"
    t.text     "medical_conditions"
    t.text     "insurance_info"
    t.string   "ec_name",                 limit: 255
    t.string   "ec_phone",                limit: 255
    t.string   "ec_relationship",         limit: 255
    t.string   "payment_method",          limit: 255
    t.string   "email",                   limit: 255
    t.string   "shirtsize",               limit: 255
    t.string   "otherparish",             limit: 255
  end

end
