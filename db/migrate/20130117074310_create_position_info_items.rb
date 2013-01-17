#coding: utf-8
#生成职位条码表
class CreatePositionInfoItems < ActiveRecord::Migration
  def self.up
    create_table :position_info_items do |t|
      t.references :position_info,:null => false
      t.string :title,:limit => 60,:null => false
      t.text :content
      t.boolean :is_active,:default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :position_info_items
  end
end
