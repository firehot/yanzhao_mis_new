#coding: utf-8
#添加系统功能分类表
class CreateSystemFunctionCats < ActiveRecord::Migration
  def self.up
    create_table :system_function_cats do |t|
      t.string :cat_name,:limit => 60,:null => false
      t.boolean :is_active,:default => true,:null => false
      t.integer :order_by,:default => 0
      t.text :note

      t.timestamps
    end
    #向system_function表中添加system_function_cat_id字段
    add_column :system_functions,:system_function_cat_id,:integer
  end

  def self.down
    drop_table :system_function_cats
    remove_column :system_functions,:system_function_cat_id
  end
end
