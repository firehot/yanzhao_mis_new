#coding: utf-8
#添加查看处罚信息及违规信息功能
class AddIndexPunishmentsFunction < ActiveRecord::Migration
  def self.up
    #查看违规信息
    sf_cat = SystemFunctionCat.find_by_cat_name('处罚记录')
    sf = SystemFunction.find_or_create_by_func_name('查看处罚记录')
    sf.update_attributes(:func_key => "index_punishments",:group_name => "违规处罚",:system_function_cat_id => sf_cat.id) if sf_cat
    #修改 处罚信息 为 新建处罚信息
    sf = SystemFunction.find_by_func_name('处罚信息')
    sf.update_attributes(:func_name => "新建处罚信息")
    #新建 查看违规记录
    sf_cat = SystemFunctionCat.find_by_cat_name('违规记录')
    sf = SystemFunction.find_or_create_by_func_name('查看违规记录')
    sf.update_attributes(:func_key => "index_violations",:group_name => "违规处罚",:system_function_cat_id => sf_cat.id) if sf_cat
  end

  def self.down
  end
end
