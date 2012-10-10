#coding: utf-8
#添加岗位津贴
class AddPositionBase2ToEmployee < ActiveRecord::Migration
  def self.up
    add_column :employees, :position_base_2, :decimal,:precision => 15,:scale => 2,:default => 0
    #向salary_table 表中添加职位工资

    add_column :salary_table_lines, :position_2_salary, :decimal,:precision => 15,:scale => 2,:default => 0
  end

  def self.down
    remove_column :employees, :position_base_2
    remove_column :salary_table_lines, :position_2_salary
  end
end
