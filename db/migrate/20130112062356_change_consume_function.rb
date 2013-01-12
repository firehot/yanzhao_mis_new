#coding: utf-8
#修改易耗品相关功能
class ChangeConsumeFunction < ActiveRecord::Migration
  def self.up
    sf_group = SystemFunctionGroup.find_by_group_name('耐用品管理')
    if sf_group
      #耐用品管理,增加两个子菜单
      #库存统计m_storages
      #部门耐用品汇总material_inout_lines
      sf_cat = SystemFunctionCat.find_by_cat_name('耐用品库存')
      sf_cat.update_attributes(:system_function_group_id => sf_group.id)
      if sf_cat
        SystemFunction.update_all("system_function_cat_id = #{sf_cat.id}","func_key = 'm_storages'")
      end
      #添加部门耐用品汇总
      sf_cat = SystemFunctionCat.find_or_create_by_cat_name('部门耐用品汇总')
      sf_cat.update_attributes(:system_function_group_id => sf_group.id,:default_action =>'material_inout_lines_path(:active_sub_tab => 11,"search[material_inout_state_eq]" => MaterialInout::STATE_CONFIRM)' )
      SystemFunction.update_all("system_function_cat_id = #{sf_cat.id}","func_key='material_inout_lines'")

      #添加易耗品库存统计
      sf_group = SystemFunctionGroup.find_by_group_name('易耗品管理')
      sf_cat = SystemFunctionCat.find_or_create_by_cat_name('易耗品库存查询')
      SystemFunction.update_all("system_function_cat_id = #{sf_cat.id}","func_key ='consumer_m_storages'")
      sf_cat.update_attributes(:system_function_group_id => sf_group.id,:default_action =>'m_storages_path(:in_what => "consumer_receipts","search[material_type_is]" => "ConsumerMaterial","search[qty_gt]" => 0,"search[material_is_active]" => true,:active_sub_tab => 10)')
    end
  end

  def self.down
  end
end
