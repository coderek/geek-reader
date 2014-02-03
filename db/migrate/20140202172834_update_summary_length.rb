class UpdateSummaryLength < ActiveRecord::Migration
  def change
    change_column :entries, :summary, :text, limit: 16777215
  end
end
