class CreateCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string "name"
      t.timestamps
    end

    remove_column :feeds, :category
    add_column :feeds, :category_id, :integer
  end
end
