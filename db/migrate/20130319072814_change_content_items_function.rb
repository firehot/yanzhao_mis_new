#coding: utf-8
#修改公司文化 -- 公司理念
#公司活动 - 公司文化
class ChangeContentItemsFunction < ActiveRecord::Migration
  def self.up
    cc = ContentClass.find_by_code('company_culture')
    cc.update_attributes(:name => "公司理念") if cc
    cc = ContentClass.find_by_code('company_activity')
    cc.update_attributes(:name => "公司活动") if cc
    sfc = SystemFunctionCat.find_by_cat_name('公司文化')
    sfc.update_attributes(:cat_name => '公司理念') if sfc

    sfc = SystemFunctionCat.find_by_cat_name('公司活动')
    sfc.update_attributes(:cat_name => '公司文化') if sfc

  end

  def self.down
  end
end
