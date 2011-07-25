class AddSalaryTableFunction < ActiveRecord::Migration
  #添加工资核算模块相关功能
  def self.up
    #工资核算
    SystemFunction.create :group_name => "工资核算",:func_name => "查看工资表",:func_key => "index_salary_table"
    SystemFunction.create :group_name => "工资核算",:func_name => "新建工资表",:func_key => "new_salary_table"
    SystemFunction.create :group_name => "工资核算",:func_name => "修改工资表",:func_key => "edit_salary_table"
    SystemFunction.create :group_name => "工资核算",:func_name => "审核工资表",:func_key => "audit_salary_table"
    SystemFunction.create :group_name => "工资核算",:func_name => "打印工资表",:func_key => "print_salary_table"
    SystemFunction.create :group_name => "工资核算",:func_name => "考勤统计",:func_key => "index_sum_salary_table"
    #员工信息管理
    SystemFunction.create :group_name => "工资核算",:func_name => "查看员工资料",:func_key => "index_employees"
    SystemFunction.create :group_name => "工资核算",:func_name => "新建员工资料",:func_key => "new_employee"
    SystemFunction.create :group_name => "工资核算",:func_name => "修改员工资料",:func_key => "edit_employees"
  end

  def self.down
    SystemFunction.find_by_func_key('index_salary_table').destroy
    SystemFunction.find_by_func_key('new_salary_table').destroy
    SystemFunction.find_by_func_key('edit_salary_table').destroy
    SystemFunction.find_by_func_key('audit_salary_table').destroy
    SystemFunction.find_by_func_key('print_salary_table').destroy
    SystemFunction.find_by_func_key('index_sum_salary_table').destroy
    #工资核算

    SystemFunction.find_by_func_key('index_employees').destroy
    SystemFunction.find_by_func_key('new_employee').destroy
    SystemFunction.find_by_func_key('edit_employee').destroy

  end
end
