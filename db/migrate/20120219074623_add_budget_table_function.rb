class AddBudgetTableFunction < ActiveRecord::Migration
  def self.up
    SystemFunction.create :group_name => "预算工具",:func_name => "新建全局预算设置信息",:func_key => "create_management_fee_config"
    SystemFunction.create :group_name => "预算工具",:func_name => "查看全局预算设置信息",:func_key => "read_management_fee_configs"
    SystemFunction.create :group_name => "预算工具",:func_name => "修改全局预算设置信息",:func_key => "update_management_fee_config"
   SystemFunction.create :group_name => "预算工具",:func_name => "新建分理处预算设置信息",:func_key => "create_org_management_fee_config"
    SystemFunction.create :group_name => "预算工具",:func_name => "查看分理处预算设置信息",:func_key => "read_org_management_fee_configs"
    SystemFunction.create :group_name => "预算工具",:func_name => "修改分理处预算设置信息",:func_key => "update_org_management_fee_config"
    SystemFunction.create :group_name => "预算工具",:func_name => "查看预算表",:func_key => "read_budget_tables"
    SystemFunction.create :group_name => "预算工具",:func_name => "新建预算表",:func_key => "create_budget_table"


  end

  def self.down
  end
end
