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

ActiveRecord::Schema.define(version: 20150308164551) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "antibodies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "account_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "doctors", ["account_id"], name: "index_doctors_on_account_id", using: :btree

  create_table "laboratories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "account_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "laboratories", ["account_id"], name: "index_laboratories_on_account_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.date     "order_date"
    t.integer  "doctor_id",       limit: 4
    t.integer  "trial_type_id",   limit: 4
    t.string   "conclusion",      limit: 255
    t.string   "tracking_number", limit: 255
    t.integer  "laboratory_id",   limit: 4
    t.string   "comment",         limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "orders", ["doctor_id"], name: "index_orders_on_doctor_id", using: :btree
  add_index "orders", ["laboratory_id"], name: "index_orders_on_laboratory_id", using: :btree
  add_index "orders", ["trial_type_id"], name: "index_orders_on_trial_type_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "trial_types", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "laboratory_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trial_types", ["laboratory_id"], name: "index_trial_types_on_laboratory_id", using: :btree

  create_table "trials", force: :cascade do |t|
    t.integer  "antibody_id", limit: 4
    t.integer  "order_id",    limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "trials", ["antibody_id"], name: "index_trials_on_antibody_id", using: :btree
  add_index "trials", ["order_id"], name: "index_trials_on_order_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "orders", "doctors"
  add_foreign_key "orders", "trial_types"
  add_foreign_key "trials", "antibodies"
  add_foreign_key "trials", "orders"
end
