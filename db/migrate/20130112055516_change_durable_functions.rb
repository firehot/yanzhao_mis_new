#coding: utf-8
#修改耐用品管理的相关功能
class ChangeDurableFunctions < ActiveRecord::Migration
  def self.up
    #添加以下功能:
    #报废单
    group_name = "耐用品管理"
    sf_group = SystemFunctionGroup.find_by_group_name(group_name)
    if sf_group
      sf_cat = sf_group.system_function_cats.find_or_create_by_cat_name('报废单')
      sf_cat.update_attributes(:default_action => "scrapped_infos_path(:active_sub_tab => 12)",:system_function_group_id => sf_group.id)
      sf = SystemFunction.find_by_func_name('new_scrapped_info')
      if sf
        sf.update_attributes(:system_function_cat_id => sf_cat.id)
      end
    end
    SystemFunctionCat.destroy_all(:cat_name => "耐用品-领用汇总")
  end

  def self.down
  end
end
