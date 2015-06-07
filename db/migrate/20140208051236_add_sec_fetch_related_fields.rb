class AddSecFetchRelatedFields < ActiveRecord::Migration
  def change
    add_column :feeds, :fetch_type, :string, :default => "append"
    add_column :entries, :secondary_fetched, :integer, :default => 0
  end
end
