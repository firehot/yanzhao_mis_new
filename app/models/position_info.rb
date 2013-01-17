#coding: utf-8
#职位信息表
class PositionInfo < ActiveRecord::Base
  belongs_to :org_info
  has_many :children,:class_name => "PositionInfo",:foreign_key => "parent_id",:order => "order_by"
end
