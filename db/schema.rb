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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130706181137) do

  create_table "addresses", :force => true do |t|
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "children", :force => true do |t|
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "grade"
    t.string   "teacher"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "gender"
    t.string   "avatar"
  end

  create_table "riderships", :force => true do |t|
    t.integer  "ride_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "status"
    t.integer  "child_id"
    t.datetime "expiration"
    t.text     "comment"
  end

  create_table "rides", :force => true do |t|
    t.integer  "gas_money"
    t.integer  "seats_total"
    t.integer  "seats_filled"
    t.text     "schedule"
    t.integer  "origin_address_id"
    t.integer  "destination_address_id"
    t.integer  "driver_id"
    t.string   "ride_type"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.text     "comment"
    t.integer  "created_by"
    t.string   "created_as"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "paypal_email"
    t.string   "gender"
    t.boolean  "verified"
    t.string   "avatar"
    t.text     "comment"
    t.string   "stripe_id"
    t.string   "last_4_digits"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
