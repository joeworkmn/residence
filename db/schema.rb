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

ActiveRecord::Schema.define(version: 20130710124004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "apartment_statuses", force: true do |t|
    t.boolean "occupied"
    t.date    "status_start_date"
    t.integer "number_of_tenants"
    t.integer "apartment_id"
    t.text    "comment"
  end

  add_index "apartment_statuses", ["apartment_id"], name: "index_apartment_statuses_on_apartment_id", using: :btree

  create_table "apartments", force: true do |t|
    t.integer "number"
    t.string  "password_digest"
    t.integer "tickets_count",   default: 0, null: false
  end

  add_index "apartments", ["number"], name: "index_apartments_on_number", unique: true, using: :btree

  create_table "schedule_entries", force: true do |t|
    t.date     "date"
    t.integer  "staff_id"
    t.integer  "shift_id"
    t.integer  "schedule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "day_or_night"
  end

  create_table "schedules", force: true do |t|
    t.integer  "year"
    t.string   "month"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["month", "year"], name: "index_schedules_on_month_and_year", unique: true, using: :btree
  add_index "schedules", ["month"], name: "index_schedules_on_month", using: :btree
  add_index "schedules", ["year"], name: "index_schedules_on_year", using: :btree

  create_table "shifts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_violations", force: true do |t|
    t.integer  "ticket_id"
    t.integer  "violation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.integer  "staff_id"
    t.integer  "apartment_id"
    t.string   "description"
    t.decimal  "total_fine",   default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid",         default: false
  end

  add_index "tickets", ["apartment_id"], name: "index_tickets_on_apartment_id", using: :btree
  add_index "tickets", ["staff_id"], name: "index_tickets_on_staff_id", using: :btree

  create_table "users", force: true do |t|
    t.string  "fname"
    t.string  "lname"
    t.string  "username"
    t.string  "password_digest"
    t.string  "email"
    t.string  "phone_primary"
    t.string  "phone_secondary"
    t.text    "roles",                           array: true
    t.integer "apartment_id"
    t.string  "current_role"
    t.boolean "tenant",          default: false
  end

  add_index "users", ["apartment_id"], name: "index_users_on_apartment_id", using: :btree
  add_index "users", ["roles"], name: "index_users_on_roles", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "violations", force: true do |t|
    t.string  "name"
    t.decimal "fine", default: 0.0
  end

end
