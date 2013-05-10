class AddColsToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :entry_mode, :string
    add_column :entries, :start_time, :timestamp
    add_column :entries, :source_id, :string
  end
end
