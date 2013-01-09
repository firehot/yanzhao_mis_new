#系统功能分组表
#coding: utf-8
class CreateSystemFunctionGroups < ActiveRecord::Migration
  def self.up
    create_table :system_function_groups do |t|
      t.string :group_name,:limit => 60,:null => false
      t.boolean :is_active,:null => false,:default => true
      t.integer :order_by,:default => 0
      t.text :note

      t.timestamps
    end
    #向system_function_cats表中添加system_function_group_id字段
    add_column :system_function_cats,:system_function_group_id,:integer
  end

  def self.down
    drop_table :system_function_groups
    remove_column :system_function_cats,:system_function_group_id
  end
end
