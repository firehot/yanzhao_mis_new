class SalaryTableLine < ActiveRecord::Base
  belongs_to :employee
  belongs_to :salary_table
  validates_presence_of :employee_id
  validates_numericality_of :work_days,:other_added,:deducted_fee
  default_scope :include => [:employee,:salary_table]
end
