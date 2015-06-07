class AddSecondaryFetchToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :secondary_fetch, :integer, :default => 0
  end
end
