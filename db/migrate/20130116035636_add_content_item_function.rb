#coding: utf-8
#添加公司简介相关功能
class AddContentItemFunction < ActiveRecord::Migration
  def self.up
    group_name = "公共信息"
    sf_group = SystemFunctionGroup.find_by_group_name(group_name)
    if sf_group
      #先添加function_cat
      func_cats = [['公司简介',"content_items_path(:content_class_code => 'company_introduce')"],["公司文化","content_items_path(:content_class_code => 'company_culture')"],["公司大事记","content_items_path(:content_class_code => 'company_log')"],["公司活动","content_items_path(:content_class_code => 'company_activity')"],["员工手册","content_items_path(:content_class_code => 'worker_manual')"]]
      func_cats.each do |c|
        sf_cat = SystemFunctionCat.create!(:system_function_group_id => sf_group.id,:cat_name => c.first,:default_action => c.second)
      end
      #添加system_function
      sfs = {
        "公司简介" =>{
          "查看公司简介" => "index_company_introduces",
          "新建公司简介" => "new_company_introduce",
          "修改公司简介" => "edit_company_introduce",
          "删除公司简介" => "destroy_company_introduce"
        },
        "公司文化" =>{
          "查看公司文化" => "index_company_cultures",
          "新建公司文化" => "new_company_culture",
          "修改公司文化" => "edit_company_culture",
          "删除公司文化" => "destroy_company_culture"
        },
        "公司大事记" =>{
          "查看公司大事记" => "index_company_logs",
          "新建公司大事记" => "new_company_log",
          "修改公司大事记" => "edit_company_log",
          "删除公司大事记" => "destroy_company_log"
        },
        "公司活动" => {
          "查看公司活动" => "index_company_activities",
          "新建公司活动" => "new_company_activity",
          "修改公司活动" => "edit_company_activity",
          "删除公司活动" => "destroy_company_activity"
        },
        "员工手册" => {
          "查看员工手册" => "index_worker_manuanls",
          "新建手册" => "new_worker_manuals",
          "修改员工手册" => "edit_worker_manuals",
          "删除员工手册" => "destroy_worker_manuals"
        }
      }
      sfs.each do |k,vs|
        vs.each do |func_name,func_key|
          sf_cat = SystemFunctionCat.find_by_cat_name(k)
          SystemFunction.create!(:system_function_cat_id => sf_cat.id,:group_name => k,:func_name => func_name,:func_key => func_key) if sf_cat
        end
      end
    end
  end

  def self.down
  end
end
