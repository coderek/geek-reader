class CreateFeedsAndEntries < ActiveRecord::Migration
  def change

    create_table "feeds", force: true do |t|
      t.string   "url"
      t.text     "title"
      t.text     "description"
      t.string   "etag"
      t.string   "feed_url",      null: false
      t.datetime "last_modified"
      t.string   "categories"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "style"
    end

    create_table "entries", force: true do |t|
      t.string   "title"
      t.string   "url"
      t.string   "author"
      t.text     "summary"
      t.text     "content",    limit: 16777215
      t.datetime "published"
      t.string   "categories"
      t.string   "uuid"
      t.integer  "is_read"
      t.integer  "is_starred"
      t.integer  "feed_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
