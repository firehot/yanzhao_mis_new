#coding: utf-8
#职位权限表
class CreatePositionInfoPowers < ActiveRecord::Migration
  def self.up
    create_table :position_info_powers do |t|
      #当前权限所属职位id
      t.references :position_info,:null => false
      #职位id
      t.integer :has_position_info_id,:null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :position_info_powers
  end
end
