#coding: utf-8
#修改员工信息表,添加职位字段
class AddPositionIdToEmployee < ActiveRecord::Migration
  def self.up
    #职位
    add_column :employees, :position_id, :integer
    #是否见习员工
    add_column :employees,:is_probation,:boolean,:default => false
  end

  def self.down
    remove_column :employees, :position_id
    remove_column :employees, :is_probation
  end
end
