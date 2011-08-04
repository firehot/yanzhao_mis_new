class AddEmployeeDestoryFunction < ActiveRecord::Migration
  def self.up
    SystemFunction.create :group_name => "工资核算",:func_name => "删除工资表",:func_key => "destroy_salary_table"
    SystemFunction.create :group_name => "工资核算",:func_name => "删除员工资料",:func_key => "destroy_employee"
  end

  def self.down
    SystemFunction.find_by_func_key('destroy_employee').destroy
    SystemFunction.find_by_func_key('destroy_salary_table').destroy
  end
end
