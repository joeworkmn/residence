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

ActiveRecord::Schema.define(version: 20130529065339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "apartment_statuses", force: true do |t|
    t.boolean "occupied"
    t.date    "since"
    t.integer "number_of_tenants"
    t.integer "apartment_id"
  end

  create_table "apartments", force: true do |t|
    t.integer "number"
  end

  create_table "users", force: true do |t|
    t.string "fname"
    t.string "lname"
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "phone_primary"
    t.string "phone_secondary"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
