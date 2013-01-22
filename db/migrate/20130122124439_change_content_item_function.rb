#coding: utf-8
#重新设置内容条目信息
class ChangeContentItemFunction < ActiveRecord::Migration
  def self.up
      func_cats = [['公司简介',"first_content_items_path(:content_class_code => 'company_introduce',:active_sub_tab => 1)"],["公司文化","first_content_items_path(:content_class_code => 'company_culture',:active_sub_tab => 1)"],["员工手册","first_content_items_path(:content_class_code => 'worker_manual',:active_sub_tab => 1)"]]
      func_cats.each do |c|
        sf_cat = SystemFunctionCat.find_by_cat_name(c[0])
        sf_cat.update_attributes(:default_action => c.second) if sf_cat
      end

  end

  def self.down
  end
end
