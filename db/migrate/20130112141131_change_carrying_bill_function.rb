#coding: utf-8
#修改票据管理相关功能
class ChangeCarryingBillFunction < ActiveRecord::Migration
  def self.up
    #修改票据管理为票据科
    sf_group = SystemFunctionGroup.find_by_group_name('票据管理')
    sf_group.update_attributes(:group_name => "票据科") if sf_group

    #添加确认清单new_confirm、核销清单new_post_info_carrying_bill
    sf_cat = SystemFunctionCat.find_or_create_by_cat_name('确认清单')
    sf_cat.update_attributes(:system_function_group_id => sf_group.id,:default_action => 'confirms_path(:active_sub_tab => 3,:in_what => :carrying_bills,"search[bills_type_is]" => "CarryingBill")') if sf_cat and sf_group
    SystemFunction.update_all("system_function_cat_id=#{sf_cat.id}","func_key = 'new_confirm'")
    sf_cat = SystemFunctionCat.find_or_create_by_cat_name('核销清单')
    sf_cat.update_attributes(:system_function_group_id => sf_group.id,:default_action => 'post_infos_path(:active_sub_tab => 6,:in_what => :carrying_bills,"search[bills_type_is]" => "CarryingBill")') if sf_cat and sf_group
    SystemFunction.update_all("system_function_cat_id=#{sf_cat.id}","func_key = 'new_post_info_carrying_bill'")
  end

  def self.down
  end
end
