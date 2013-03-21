#coding: utf-8
#添加职位结构图功能
class AddPositionInfoFunction < ActiveRecord::Migration
  def self.up
    #添加总公司与分公司根目录
    root_1 = PositionInfo.find_or_create_by_name('corporation')
    root_2 = PositionInfo.find_or_create_by_name('subsidiary')
    sfg = SystemFunctionGroup.find_or_create_by_group_name('公司管理机构')
    #添加两个功能
    #总公司职位架构图
    #子公司职位架构图
    sfc = SystemFunctionCat.find_or_create_by_cat_name('职位架构图')
    sfc.update_attributes(:system_function_group_id => sfg.id,:default_action => "position_infos_path(:level => 'corporation')")
    #修改system_function中system_function_cat_id为sfc的id
    SystemFunction.update_all("system_function_cat_id = #{sfc.id}","func_key in ('index_position_infos','new_position_info','update_position_info','destroy_position_info') ")
 end

  def self.down
  end
end
