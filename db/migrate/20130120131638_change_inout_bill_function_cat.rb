#coding: utf-8
#修改提货单相关功能
class ChangeInoutBillFunctionCat < ActiveRecord::Migration
  def self.up
    sf_group = SystemFunctionGroup.find_by_group_name('后勤部')
    #添加确认清单new_confirm、核销清单new_post_info_carrying_bill
    sf_cat = SystemFunctionCat.find_or_create_by_cat_name('后勤-确认清单')
    sf_cat.update_attributes(:system_function_group_id => sf_group.id,:default_action => 'confirms_path(:active_sub_tab => 3,:in_what => :inout_bills,"search[bills_type_is]" => "InoutBill")')
    SystemFunction.update_all("system_function_cat_id=#{sf_cat.id}","func_key = 'new_confirm_inout_bill'")
    sf_cat = SystemFunctionCat.find_or_create_by_cat_name('后勤-核销清单')
    sf_cat.update_attributes(:system_function_group_id => sf_group.id,:default_action => 'post_infos_path(:active_sub_tab => 6,:in_what => :inout_bills,"search[bills_type_is]" => "InoutBill")')
    SystemFunction.update_all("system_function_cat_id=#{sf_cat.id}","func_key = 'new_post_info_inout_bill'")
  end

  def self.down
  end
end
