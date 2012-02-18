class BudgetTable < ActiveRecord::Base
  belongs_to :org
  validates_numericality_of :sum_carrying_fee,:commission_rate,:rent_fee,:salary_rate,:utilities_fee,:office_fee,:communication_fee,:profit_rate,:goods_loaded,:distance,:fuel_fee,:compensate_rate,:vehicle_fee
end
