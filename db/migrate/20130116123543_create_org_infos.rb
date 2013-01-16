#coding: utf-8
#添加机构信息表
class CreateOrgInfos < ActiveRecord::Migration
  def self.up
    create_table :org_infos do |t|
      t.string :name,:limit => 30,:null => false
      t.integer :parent_id
      t.boolean :is_active,:default => true,:null => false
      t.text :note
      t.integer :order_by,:default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :org_infos
  end
end
