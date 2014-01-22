class ChangeFeedCategoriesName < ActiveRecord::Migration
  def change
    rename_column :feeds, :categories, :category
  end
end
