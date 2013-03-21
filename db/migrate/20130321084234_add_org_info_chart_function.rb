#coding: utf-8
#添加公司机构图
class AddOrgInfoChartFunction < ActiveRecord::Migration
  def self.up
    cc = ContentClass.find_or_create_by_name_and_code('组织机构图','org_chart')
    sfc = SystemFunctionCat.find_or_create_by_cat_name('管理机构图')
    sfc.update_attributes(:default_action => "first_content_items_path(:content_class_code => 'org_chart' )")
  end

  def self.down
  end
end
