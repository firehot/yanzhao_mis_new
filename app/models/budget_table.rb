class BudgetTable < ActiveRecord::Base
  belongs_to :org
  validates_numericality_of :sum_carrying_fee,:commission_rate,:rent_fee,:salary_rate,:utilities_fee,:office_fee,:communication_fee,:profit_rate,:goods_loaded,:distance,:fuel_fee,:compensate_rate,:vehicle_fee
  #构造函数
  def self.new_with_org_id_and_sum_carrying_fee(a_org_id,a_sum_carrying_fee)
    budget_table = BudgetTable.new
    budget_table.org_id = a_org_id
    budget_table.sum_carrying_fee = a_sum_carrying_fee
    global_config = ManagementFeeConfig.first
    org_config = OrgManagementFeeConfig.find_by_org_id(a_org_id)
    budget_table.commission_rate = global_config.try(:commission_rate)
    budget_table.salary_rate = global_config.try(:salary_rate)
    budget_table.profit_rate = global_config.try(:profit_rate)
    budget_table.compensate_rate = global_config.try(:compensate_rate)
    budget_table.rent_fee = org_config.try(:rent_fee)
    budget_table.utilities_fee = global_config.try(:utilities_fee)
    budget_table.office_fee = org_config.try(:office_fee)
    budget_table.communication_fee = global_config.try(:communication_fee)
    budget_table.goods_loaded = org_config.try(:goods_loaded)
    budget_table.distance = org_config.try(:distance)
    budget_table.fuel_fee = org_config.try(:fuel_fee)
    budget_table.vehicle_fee = global_config.try(:vehicle_fee)
    budget_table
  end
  #提成额 = 月均货量 * 提成比例
  def commission_fee
    (self.sum_carrying_fee*commission_rate).to_f.roundf(2)
  end
  #管理费比例 = 月管理费
  #工资 = 月均货量 * 工资比例
  def salary_fee
    (sum_carrying_fee * salary_rate).to_f.roundf(2)
  end
  #利润
  def profit_fee
    (sum_carrying_fee * profit_rate).to_f.roundf(2)
  end
  #赔偿 = 月均货量 * 赔偿比例
  def compensate_fee
    (sum_carrying_fee * compensate_rate).to_f.roundf(2)
  end
  #盘货费 = (月均货量 / 装货量 * 110% * 距离 * 油耗)
  def inventory_fee
    (sum_carrying_fee/goods_loaded*1.1*distance*fuel_fee).to_f.roundf(2)
  end
  #预算费用合计
  def sum_budget_fee
    rent_fee + salary_fee + utilities_fee + communication_fee + office_fee + profit_fee + inventory_fee + compensate_fee + vehicle_fee

  end
  #月管理费 = 提成额 - 预算费用合计
  def management_fee_per_month
    commission_fee - sum_budget_fee
  end
  #管理费比例 = 月管理费 / 月均货量
  def management_fee_rate
    (management_fee_per_month/sum_carrying_fee).to_f.roundf(2)
  end
end
