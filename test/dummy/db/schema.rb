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

ActiveRecord::Schema.define(version: 20140620111207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "csf_accounts", force: true do |t|
    t.integer  "state_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "csf_accounts", ["name"], name: "index_csf_accounts_on_name", unique: true, using: :btree
  add_index "csf_accounts", ["state_id"], name: "index_csf_accounts_on_state_id", using: :btree

  create_table "csf_registration_requests", force: true do |t|
    t.string   "organization_name",                 null: false
    t.string   "state",                             null: false
    t.string   "website"
    t.string   "admin_name",                        null: false
    t.string   "admin_title",                       null: false
    t.string   "admin_email",                       null: false
    t.string   "admin_phone"
    t.boolean  "archived",          default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "csf_registration_requests", ["archived"], name: "index_csf_registration_requests_on_archived", using: :btree

  create_table "csf_states", force: true do |t|
    t.string "code", null: false
    t.string "name", null: false
  end

  create_table "csf_users", force: true do |t|
    t.integer  "account_id",                                      null: false
    t.string   "login",                                           null: false
    t.string   "crypted_password",                                null: false
    t.string   "salt",                                            null: false
    t.string   "first_name",                                      null: false
    t.string   "last_name",                                       null: false
    t.string   "email",                                           null: false
    t.boolean  "admin",                           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "phone"
    t.string   "title"
  end

  add_index "csf_users", ["account_id"], name: "index_csf_users_on_account_id", using: :btree
  add_index "csf_users", ["login"], name: "index_csf_users_on_login", unique: true, using: :btree
  add_index "csf_users", ["remember_me_token"], name: "index_csf_users_on_remember_me_token", using: :btree
  add_index "csf_users", ["reset_password_token"], name: "index_csf_users_on_reset_password_token", using: :btree

end
