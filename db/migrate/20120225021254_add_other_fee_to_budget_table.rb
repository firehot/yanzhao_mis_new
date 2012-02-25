class AddOtherFeeToBudgetTable < ActiveRecord::Migration
  def self.up
    add_column :budget_tables, :other_item_name1, :string,:limit => 20
    add_column :budget_tables, :other_item_fee1, :decimal,:precision => 15,:scale => 2,:default => 0
    add_column :budget_tables, :other_item_name2, :string,:limit => 20
    add_column :budget_tables, :other_item_fee2, :decimal,:precision => 15,:scale => 2,:default => 0
  end

  def self.down
    remove_column :budget_tables, :other_item_fee2
    remove_column :budget_tables, :other_item_name2
    remove_column :budget_tables, :other_item_fee1
    remove_column :budget_tables, :other_item_name1
  end
end
