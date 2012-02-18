class ManagementFeeConfig < ActiveRecord::Base
  validates_numericality_of :commission_rate,:salary_rate,:profit_rate,:compensate_rate,:utilities_fee,:communication_fee,:vehicle_fee
  def commission_rate_display
    self.commission_rate*100
  end
  def commission_rate_display= value
    self.commission_rate = value.to_d/100
  end
  def salary_rate_display
    self.salary_rate*100
  end
  def salary_rate_display= value
    self.salary_rate = value.to_d/100
  end
  def profit_rate_display
    self.profit_rate*100
  end
  def profit_rate_display= value
    self.profit_rate = value.to_d/100
  end
  def compensate_rate_display
    self.compensate_rate*100
  end
  def compensate_rate_display= value
    self.compensate_rate = value.to_d/100
  end

end
