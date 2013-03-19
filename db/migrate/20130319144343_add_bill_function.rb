#coding: utf-8
#添加票据管理中的审核功能
class AddBillFunction < ActiveRecord::Migration
  def self.up
    #票据管理-确认清单
    #票据管理-核销清单
    sfc = SystemFunctionCat.find_or_create_by_cat_name('确认清单')
    sf = SystemFunction.find_or_create_by_func_key('audit_confirm_carrying_bills')
    sf.update_attributes(:system_function_cat_id => sfc.id,:func_name => "审核确认单",:group_name => "票据管理")

    sfc = SystemFunctionCat.find_or_create_by_cat_name('核销清单')
    sf = SystemFunction.find_or_create_by_func_key('audit_post_info_carrying_bills')
    sf.update_attributes(:system_function_cat_id => sfc.id,:func_name => "审核核销单",:group_name => "票据管理")

    #后勤
    sfc = SystemFunctionCat.find_or_create_by_cat_name('后勤-确认清单')
    sf = SystemFunction.find_or_create_by_func_key('audit_confirm_inout_bills')
    sf.update_attributes(:system_function_cat_id => sfc.id,:func_name => "审核确认单",:group_name => "提货单管理")

    sfc = SystemFunctionCat.find_or_create_by_cat_name('后勤-核销清单')
    sf = SystemFunction.find_or_create_by_func_key('audit_post_info_inout_bills')
    sf.update_attributes(:system_function_cat_id => sfc.id,:func_name => "审核核销单",:group_name => "提货单管理")



  end

  def self.down
  end
end
