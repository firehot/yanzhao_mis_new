#coding: utf-8
#修改提货票据功能
class ChangeInoutBillFunction < ActiveRecord::Migration
  def self.up
    #修改提货单管理名称为后勤部
    sf_group = SystemFunctionGroup.find_by_group_name('提货单管理')
    if sf_group
      sf_group.update_attributes(:group_name => "后勤部")
    end
  end

  def self.down
  end
end
