class SalaryTable < ActiveRecord::Base
  belongs_to :user
  has_many :salary_table_lines
  accepts_nested_attributes_for :salary_table_lines
  def self.new_with_mth(mth = 1.months.ago.strftime('%y%m'))
    salary_table = self.new(:mth => mth,:bill_date => Date.today)
    Employee.find(:all,:conditions => {:is_active => true},:order => "org_id").each do |e|
      salary_table.salary_table_lines.build(:employee => e)
    end
    salary_table
  end
end