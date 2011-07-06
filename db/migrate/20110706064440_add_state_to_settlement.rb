class AddStateToSettlement < ActiveRecord::Migration
  def self.up
    #对结算表添加状态
    add_column :settlements, :state, :string,:default => "draft",:limit => 20
    SystemFunction.create :group_name => "分成结算",:func_name => "审核结算表",:func_key => "audit_settlement"
  end

  def self.down
    remove_column :settlements, :state
    sf = SystemFunction.find_by_func_key(audit_settlement)
    sf.destroy if sf.present?
  end
end
