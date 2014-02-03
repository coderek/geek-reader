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

ActiveRecord::Schema.define(version: 20140203044340) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "entries", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "author"
    t.text     "summary",    limit: 16777215
    t.text     "content",    limit: 16777215
    t.datetime "published"
    t.string   "categories"
    t.string   "uuid"
    t.integer  "is_read",                     default: 0
    t.integer  "is_starred",                  default: 0
    t.integer  "feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", force: true do |t|
    t.string   "url"
    t.text     "title"
    t.text     "description"
    t.string   "etag"
    t.string   "feed_url",      null: false
    t.datetime "last_modified"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "style"
    t.integer  "category_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "auth_token"
    t.datetime "last_feed_update"
    t.text     "password_digest"
  end

end
