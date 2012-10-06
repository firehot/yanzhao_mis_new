#coding: utf-8
#添加职位管理功能
class AddPositionFunction < ActiveRecord::Migration
  def self.up
    SystemFunction.create :group_name => "工资核算",:func_name => "查看职位资料",:func_key => "index_positions"
    SystemFunction.create :group_name => "工资核算",:func_name => "新建职位资料",:func_key => "new_position"
    SystemFunction.create :group_name => "工资核算",:func_name => "修改职位资料",:func_key => "edit_position"
    SystemFunction.create :group_name => "工资核算",:func_name => "删除职位资料",:func_key => "destroy_position"
  end

  def self.down
    SystemFunction.find_by_func_key('index_positions').destroy
    SystemFunction.find_by_func_key('new_position').destroy
    SystemFunction.find_by_func_key('edit_position').destroy
    SystemFunction.find_by_func_key('destroy_position').destroy
  end
end
