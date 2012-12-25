#coding: utf-8
#添加保险费字段
class AddInsuredFee < ActiveRecord::Migration
  def self.up
    add_column :bills,:insured_fee,:decimal,:precision => 15,:scale => 2,:default => 0
  end

  def self.down
    remove_column :bills,:insured_fee
  end
end
