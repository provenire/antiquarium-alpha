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

ActiveRecord::Schema.define(version: 20140908014739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "hstore"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "artifacts", force: true do |t|
    t.uuid     "uuid",            null: false
    t.string   "name",            null: false
    t.string   "alternate_names",              array: true
    t.text     "description"
    t.string   "artist"
    t.string   "dimensions"
    t.string   "date_created"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artifacts_events", id: false, force: true do |t|
    t.integer "artifact_id", null: false
    t.integer "event_id",    null: false
  end

  create_table "artifacts_photos", id: false, force: true do |t|
    t.integer "artifact_id", null: false
    t.integer "photo_id",    null: false
  end

  create_table "citations", force: true do |t|
    t.integer  "event_id"
    t.integer  "source_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employments", force: true do |t|
    t.integer  "person_id",   null: false
    t.integer  "place_id",    null: false
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "current_job"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employments", ["person_id"], name: "index_employments_on_person_id", using: :btree
  add_index "employments", ["place_id"], name: "index_employments_on_place_id", using: :btree

  create_table "events", force: true do |t|
    t.uuid     "uuid",                               null: false
    t.date     "date"
    t.string   "verb",           default: "unknown", null: false
    t.text     "details"
    t.boolean  "failed",         default: false,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_cents",    default: 0,         null: false
    t.string   "price_currency", default: "USD",     null: false
  end

  create_table "interactions", force: true do |t|
    t.integer  "actor_id"
    t.string   "actor_type"
    t.integer  "event_id"
    t.boolean  "recipient",     default: true,  null: false
    t.boolean  "unknown_actor", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.integer  "locatable_id"
    t.string   "locatable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.uuid     "uuid",                              null: false
    t.string   "name",                              null: false
    t.text     "description"
    t.string   "gender",        default: "unknown", null: false
    t.date     "date_of_birth"
    t.date     "date_of_death"
    t.string   "nationality",   default: "unknown", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people_photos", id: false, force: true do |t|
    t.integer "person_id", null: false
    t.integer "photo_id",  null: false
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "image"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos_places", id: false, force: true do |t|
    t.integer "photo_id", null: false
    t.integer "place_id", null: false
  end

  create_table "places", force: true do |t|
    t.uuid     "uuid",        null: false
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", force: true do |t|
    t.uuid     "uuid",                          null: false
    t.string   "name",                          null: false
    t.text     "description"
    t.string   "status",      default: "ready", null: false
    t.string   "thumbnail"
    t.string   "document"
    t.string   "type"
    t.hstore   "specifics"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "name",                   default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,      null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unconfirmed_email"
    t.string   "role",                   default: "user"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "verbs", force: true do |t|
    t.string "display"
    t.string "keyword"
    t.string "components", default: ["date", "failed", "details"], array: true
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
