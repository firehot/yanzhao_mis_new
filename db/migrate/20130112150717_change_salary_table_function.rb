#coding: utf-8
#修改工资表相关功能
class ChangeSalaryTableFunction < ActiveRecord::Migration
  def self.up
    #添加职位设置function_cat
    sf_group = SystemFunctionGroup.find_by_group_name('工资核算')
    sf_cat = SystemFunctionCat.find_or_create_by_cat_name('职位设置')
    if sf_group
      sf_cat.update_attributes(:system_function_group_id => sf_group.id,:default_action => 'positions_path(:active_sub_tab => 3)')
      #更新相关功能到sf_cat下
      SystemFunction.update_all("system_function_cat_id=#{sf_cat.id}","func_key in ('index_positions','new_position','edit_position','destroy_position')")
    end
  end

  def self.down
  end
end
