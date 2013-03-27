#coding: utf-8
#添加机构信息相关功能
class AddOrgInfoFunction < ActiveRecord::Migration
  def self.up
    #先创建system_function_group
    sf_group = SystemFunctionGroup.find_or_create_by_group_name("公司管理机构")
    sf_group.update_attributes(:icon => 'org-info-cat-l')
    #创建system_function_cat
    sf_cat = SystemFunctionCat.find_or_create_by_cat_name('管理机构图')
    sf_cat.update_attributes(:default_action => 'org_infos_path',:system_function_group_id => sf_group.id)
    #创建system_function
    sfs = {"公司机构管理" => [["查看组织机构",'index_org_infos'],["增加组织机构",'new_org_info'],['修改组织机构','update_org_info'],['删除组织机构','destroy_org_info']],
           "岗位管理" => [["查看岗位",'index_position_infos'],["增加岗位",'new_position_info'],['修改岗位','update_position_info'],['删除岗位','destroy_position_info']],
           "岗位文件" => [["查看岗位文件",'index_position_info_items'],["增加岗位文件",'new_position_info_item'],['修改岗位文件','update_position_info_item'],['删除岗位文件','destroy_position_info_item']]
    }
    sfs.each do |k,vs|
      vs.each do |item|
        sf = SystemFunction.find_by_func_key(item[1])
        SystemFunction.create(:system_function_cat => sf_cat,:group_name => k,:func_name => item[0],:func_key => item[1]) unless sf
      end
    end
  end

  def self.down
  end
end
