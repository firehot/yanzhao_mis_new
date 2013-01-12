#coding: utf-8
#修改票据管理功能
class ChangeInvoiceFunction < ActiveRecord::Migration
  def self.up
    #添加票据分类system_function_cat
    sf_group = SystemFunctionGroup.find_by_group_name('票据登记')

    if sf_group
      sf_cat = SystemFunctionCat.find_or_create_by_cat_name('票据分类')
      sf_cat.update_attributes(:system_function_group_id => sf_group.id,:default_action => 'common_invoices_path(:active_sub_tab => 5)')
      #更新相关system_function的system_function_cat_id
      SystemFunction.update_all("system_function_cat_id = #{sf_cat.id}","func_key in ('new_common_invoice','update_common_invoice')")
    end
    #修改票据库存统计
    sf_cat = SystemFunctionCat.find_by_cat_name('票据库存统计')
    sf_cat.update_attributes(:default_action => "index_invoice_m_storages_path(:active_sub_tab => 11)")
  end

  def self.down
  end
end
