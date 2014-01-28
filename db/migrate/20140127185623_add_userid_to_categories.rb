class AddUseridToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :user_id, :integer
  end
end
