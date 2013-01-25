#coding: utf-8
#添加职位id到用户信息设置中
class AddPositionInfoIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users,:position_info_id,:integer
  end

  def self.down
    remove_column :users,:position_info_id
  end
end
