#coding: utf-8
#添加机构排序字段
class AddOrderByToOrg < ActiveRecord::Migration
  def self.up
    add_column :orgs,:order_by,:integer,:default => 0
  end

  def self.down
    remove_column :orgs,:order_by
  end
end
