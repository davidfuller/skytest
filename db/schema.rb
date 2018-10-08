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

ActiveRecord::Schema.define(version: 20181008072051) do

  create_table "bss_channel_joins", force: :cascade do |t|
    t.integer  "channel_id",      limit: 4
    t.integer  "bss_title_id_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "bss_title_ids", force: :cascade do |t|
    t.string   "bss_title_id", limit: 255
    t.integer  "episode_id",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "channel_types", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.boolean  "tx"
    t.boolean  "has_promotion"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "channels", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "code",            limit: 255
    t.integer  "channel_type_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "clip_channel_joins", force: :cascade do |t|
    t.integer  "clip_id",    limit: 4
    t.integer  "channel_id", limit: 4
    t.boolean  "tx"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "clip_device_joins", force: :cascade do |t|
    t.integer  "clip_id",        limit: 4
    t.integer  "device_type_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "clip_type_channel_joins", force: :cascade do |t|
    t.integer  "clip_type_id", limit: 4
    t.integer  "channel_id",   limit: 4
    t.boolean  "tx"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "clip_type_device_joins", force: :cascade do |t|
    t.integer  "clip_type_id",   limit: 4
    t.integer  "device_type_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "clip_types", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "description",       limit: 65535
    t.integer  "default_duration",  limit: 4
    t.boolean  "default_has_audio"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "clips", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "note",            limit: 65535
    t.string   "filename",        limit: 255
    t.integer  "folder_id",       limit: 4
    t.boolean  "has_audio"
    t.string   "audio_filename",  limit: 255
    t.integer  "clip_type_id",    limit: 4
    t.integer  "duration",        limit: 4
    t.string   "start_season",    limit: 255
    t.string   "start_episode",   limit: 255
    t.string   "end_season",      limit: 255
    t.string   "end_episode",     limit: 255
    t.boolean  "season_generic"
    t.boolean  "totally_generic"
    t.datetime "first_use"
    t.datetime "last_use"
    t.datetime "completion"
    t.integer  "user_id",         limit: 4
    t.integer  "status_id",       limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "device_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "episodes", force: :cascade do |t|
    t.string   "year",          limit: 255
    t.string   "season",        limit: 255
    t.string   "episode",       limit: 255
    t.integer  "title_id",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "episode_title", limit: 255
    t.integer  "int_year",      limit: 4
    t.integer  "int_season",    limit: 4
    t.integer  "int_episode",   limit: 4
  end

  add_index "episodes", ["title_id"], name: "index_episodes_on_title_id", using: :btree

  create_table "folders", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "note",        limit: 65535
    t.string   "clipstore",   limit: 255
    t.string   "proxy",       limit: 255
    t.string   "jpeg",        limit: 255
    t.integer  "clip_limit",  limit: 4
    t.integer  "overflow_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "position",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "titles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "role",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "episodes", "titles"
end
