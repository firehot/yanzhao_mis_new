class AddSignSettlementFunction < ActiveRecord::Migration
  def self.up
    SystemFunction.create :group_name => "分成结算",:func_name => "分成结算签字",:func_key => "sign_settlement"
  end

  def self.down
    func = SystemFunction.find_by_func_key('sign_settlement')
    func.destroy if func
  end

end
