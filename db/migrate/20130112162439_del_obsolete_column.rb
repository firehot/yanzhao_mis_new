#coding: utf-8
#删除system_function中不需要的字段
class DelObsoleteColumn < ActiveRecord::Migration
  def self.up
    remove_column :system_functions,:cat_name
    remove_column :system_functions,:default_action
  end

  def self.down
  end
end
