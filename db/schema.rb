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


ActiveRecord::Schema.define(version: 20160519021345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "contracts", force: :cascade do |t|
    t.integer  "lender_id"
    t.integer  "borrower_id"
    t.integer  "loan_request_id"
    t.integer  "loan_offer_id"
    t.string   "status",          default: "Pending"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "active",          default: true
  end

  add_index "contracts", ["borrower_id"], name: "index_contracts_on_borrower_id", using: :btree
  add_index "contracts", ["lender_id", "borrower_id"], name: "index_contracts_on_lender_id_and_borrower_id", using: :btree
  add_index "contracts", ["lender_id"], name: "index_contracts_on_lender_id", using: :btree

  create_table "loan_offers", force: :cascade do |t|
    t.float    "rate"
    t.integer  "term"
    t.integer  "amount"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "active",     default: true
  end

  add_index "loan_offers", ["user_id"], name: "index_loan_offers_on_user_id", using: :btree

  create_table "loan_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount"
    t.decimal  "rate"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "term"
    t.boolean  "active",     default: true
  end

  add_index "loan_requests", ["user_id"], name: "index_loan_requests_on_user_id", using: :btree

  create_table "loans", force: :cascade do |t|
    t.float   "rate"
    t.integer "term"
    t.integer "amount"
    t.boolean "active",    default: true
    t.integer "user_id"
    t.string  "loan_type"
  end

  add_index "loans", ["user_id"], name: "index_loans_on_user_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "quantity"
  end

  add_index "order_items", ["item_id"], name: "index_order_items_on_item_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "password_digest"
    t.string   "address"
    t.integer  "role"
    t.string   "username"
    t.boolean  "active",                 default: true
    t.string   "description"
    t.string   "image_path"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_foreign_key "loan_offers", "users"
  add_foreign_key "loan_requests", "users"
  add_foreign_key "loans", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
end
