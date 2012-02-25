class AddDestroyFunctionToBudgetTable < ActiveRecord::Migration
  def self.up
    SystemFunction.create :group_name => "预算工具",:func_name => "删除全局预算设置信息",:func_key => "destroy_management_fee_config"
    SystemFunction.create :group_name => "预算工具",:func_name => "删除分理处预算设置信息",:func_key => "destroy_org_management_fee_config"
    SystemFunction.create :group_name => "预算工具",:func_name => "删除预算表",:func_key => "destroy_budget_table"

  end

  def self.down
  end
end
