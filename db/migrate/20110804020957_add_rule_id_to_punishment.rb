class AddRuleIdToPunishment < ActiveRecord::Migration
  def self.up
    #处罚依据
    add_column :punishments, :rule_id, :integer
    change_column :punishments,:title,:string,:limit => 60,:null => true
  end

  def self.down
    #处罚依据
    remove_column :punishments, :rule_id
    change_column :punishments,:title,:string,:limit => 60,:null => false
  end
end
