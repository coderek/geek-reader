class AddDefaults < ActiveRecord::Migration
  def change
    change_column :entries, :is_read, :integer, :default => 0
    change_column :entries, :is_starred, :integer, :default => 0

  end
end
