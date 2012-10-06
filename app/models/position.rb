#coding: utf-8
#职位
class Position < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :salary_base,:position_base,:food_base,:house_base
end
