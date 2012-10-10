#coding: utf-8
#员工信息表
class Employee < ActiveRecord::Base
  belongs_to :org
  belongs_to :position
  validates_presence_of :name,:org_id,:entry_date
  validates_numericality_of :salary_base,:work_year_base,:position_base,:food_base,:house_base
  default_scope :order => "code ASC"

  #试用员工调整基本工资
  #15号之前入职,按照1300,1400,岗位工资(转正)
  #15号之后入职,按照1300,1300,1400,岗位工资(转正)
  #当月发上月工资
  def adjust_salary_base
    position_salary_base = self.position.try(:salary_base)
    return unless position_salary_base
    if self.is_probation
      if self.entry_date.day <= 15
        #入职后第一个月按照基本工资 - 200发放
        self.update_attributes(:salary_base => position_salary_base - 200) if self.entry_date.months_since(1).at_beginning_of_month == Date.today.at_beginning_of_month
        #入职后第二个月按照基本工资 - 100发放
        self.update_attributes(:salary_base => position_salary_base - 100) if self.entry_date.months_since(2).at_beginning_of_month == Date.today.at_beginning_of_month

        #入职后第三个月按照基本工资 发放
        self.update_attributes(:salary_base =>position_salary_base,:is_probation => false) if self.entry_date.months_since(3).at_beginning_of_month == Date.today.at_beginning_of_month
      else
        #入职后第一个月按照基本工资 - 200发放
        self.update_attributes(:salary_base => position_salary_base - 200) if self.entry_date.months_since(1).at_beginning_of_month == Date.today.at_beginning_of_month
        #入职后第二个月按照基本工资 - 200发放
        self.update_attributes(:salary_base => position_salary_base - 200) if self.entry_date.months_since(2).at_beginning_of_month == Date.today.at_beginning_of_month
        #入职后第三个月按照基本工资 - 100发放
        self.update_attributes(:salary_base => position_salary_base - 100) if self.entry_date.months_since(3).at_beginning_of_month == Date.today.at_beginning_of_month
        #入职后第4个月按照基本工资 发放
        self.update_attributes(:salary_base => position_salary_base,:is_probation => false) if self.entry_date.months_since(4).at_beginning_of_month == Date.today.at_beginning_of_month

      end
    end
  end
  #调整所有试用期员工工资
  def self.adjust_all_probation_salary_base
    Employee.find(:all,:conditions => {:is_active => true,:is_probation => true},:order => "order_by").each do |e|
      e.adjust_salary_base
    end
  end
end
