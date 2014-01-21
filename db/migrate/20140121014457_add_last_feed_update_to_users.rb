class AddLastFeedUpdateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_feed_update, :timestamp
  end
end
