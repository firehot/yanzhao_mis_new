#coding: utf-8
#重新设置票据管理相关功能
class ChangeInvoiceFunctionCat < ActiveRecord::Migration
  def self.up
    sf_group = SystemFunctionGroup.find_by_group_name('票据登记')
    sfs_map ={
      "hand_invoice_shippment" => ["票据领用",'all_invoice_shippments_path(:active_sub_tab => 1) '],
      "common_invoice_shippment" => ["票据领用",'all_invoice_shippments_path(:active_sub_tab => 1)'],
      "computer_invoice_shippment" => ["票据领用",'all_invoice_shippments_path(:active_sub_tab => 1)']
    }
    if sf_group
      SystemFunction.all.each do |sf|
        sfs_map.keys.each do |key|
          if sf.func_key.include? key
            sf_cat = SystemFunctionCat.find_or_create_by_cat_name(sfs_map[key][0])
            sf_cat.update_attributes(:system_function_group_id => sf_group.id,:default_action => sfs_map[key][1])
            sf.update_attributes(:system_function_cat_id => sf_cat.id)
          end
        end
      end
    end
  end

  def self.down
  end
end
