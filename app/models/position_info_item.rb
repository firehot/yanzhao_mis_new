#coding: utf-8
#职位条目信息
class PositionInfoItem < ActiveRecord::Base
  belongs_to :position_info
  validates_presence_of :title
  default_value_for :is_active,true
end
