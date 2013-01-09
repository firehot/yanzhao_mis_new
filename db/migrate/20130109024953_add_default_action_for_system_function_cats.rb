#coding: utf-8
#向system_function_cats添加default_action字段
class AddDefaultActionForSystemFunctionCats < ActiveRecord::Migration
  def self.up
    add_column :system_function_cats,:default_action,:string,:limit => 200
    #添加图标字段
    add_column :system_function_cats,:icon,:string,:limit => 60
    #给system_function_group添加图标字段
    add_column :system_function_groups,:icon,:string,:limit => 60
  end

  def self.down
    remove_column :system_function_cats,:default_action
    remove_column :system_function_cats,:icon
    remove_column :system_function_groups,:icon
  end
end
