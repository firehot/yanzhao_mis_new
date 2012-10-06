#coding: utf-8
#员工信息表
class Employee < ActiveRecord::Base
  belongs_to :org
  belongs_to :position
  validates_presence_of :name,:org_id,:entry_date
  validates_numericality_of :salary_base,:work_year_base,:position_base,:food_base,:house_base
  default_scope :order => "code ASC"
end
