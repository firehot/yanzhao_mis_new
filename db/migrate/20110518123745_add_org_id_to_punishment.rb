class AddOrgIdToPunishment < ActiveRecord::Migration
  def self.up
    #处罚金额
    add_column :punishments,:org_id,:integer
    #处罚金额
    add_column :punishments,:punishment_fee,:integer,:default => 0
    #修改处罚记录
    SystemFunction.create :group_name => "违规处罚",:func_name => "修改处罚信息",:func_key => "edit_punishment"
  end

  def self.down
    remove_column :punishements,:org_id
    remove_column :punishements,:punishment_fee
    SystemFunction.find_by_func_key('edit_punishment').destroy!
  end
end
