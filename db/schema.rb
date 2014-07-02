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

ActiveRecord::Schema.define(version: 20140702074052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "hstore"

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

  create_table "artifacts_photos", id: false, force: true do |t|
    t.integer "artifact_id", null: false
    t.integer "photo_id",    null: false
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
    t.uuid     "uuid",                           null: false
    t.date     "date"
    t.string   "verb",       default: "unknown", null: false
    t.text     "details"
    t.boolean  "failed",     default: false,     null: false
    t.string   "price"
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

end
