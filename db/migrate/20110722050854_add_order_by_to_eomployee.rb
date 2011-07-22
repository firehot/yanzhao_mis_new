class AddOrderByToEomployee < ActiveRecord::Migration
  def self.up
    add_column :employees, :order_by, :integer,:default => 0
  end

  def self.down
    remove_column :employees, :order_by
  end
end
