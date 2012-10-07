class ChangEntryDateFromEmployee < ActiveRecord::Migration
  def self.up
    change_column :employees,:entry_date,:date,:null => false
  end

  def self.down
    change_column :employees,:entry_date,:string,:limit => 20
  end
end
