#coding: utf-8
#职位信息表
class PositionInfo < ActiveRecord::Base
  belongs_to :org_info
  has_many :children,:class_name => "PositionInfo",:foreign_key => "parent_id",:order => "order_by"
  has_many :position_info_items
  validates_presence_of :org_info_id,:name

  default_value_for :is_active,true
end
