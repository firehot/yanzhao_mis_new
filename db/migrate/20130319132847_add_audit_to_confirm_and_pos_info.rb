#coding: utf-8
#向confirms/post_infos表中添加state auditor_id audit_date
class AddAuditToConfirmAndPosInfo < ActiveRecord::Migration
  def self.up
    add_column :confirms,:state,:string,:limit => "10",:default => "DR"
    add_column :confirms,:auditor_id,:integer
    add_column :confirms,:audit_date,:datetime
    add_column :post_infos,:state,:string,:limit => "10",:default => "DR"
    add_column :post_infos,:auditor_id,:integer
    add_column :post_infos,:audit_date,:datetime
    change_column :bills,:state,:string,:size => 10,:default => "DR",:null => false

  end

  def self.down
    remove_column :confirms,:state
    remove_column :confirms,:auditor_id
    remove_column :confirms,:audit_date
    remove_column :post_infos,:state
    remove_column :post_infos,:auditor_id
    remove_column :post_infos,:audit_date
  end
end
