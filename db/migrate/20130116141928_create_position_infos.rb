#coding: utf-8
#职位信息表
class CreatePositionInfos < ActiveRecord::Migration
  def self.up
    create_table :position_infos do |t|
      t.references :org_info
      t.string :name,:limit => 60,:null => false
      t.boolean :is_active,:default => true
      t.integer :parent_id
      t.text :note
      t.integer :order_by

      t.timestamps
    end
  end

  def self.down
    drop_table :position_infos
  end
end
