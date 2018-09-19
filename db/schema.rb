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

ActiveRecord::Schema.define(version: 20180919131025) do

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
