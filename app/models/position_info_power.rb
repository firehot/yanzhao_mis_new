#coding: utf-8
#职位权限设置
class PositionInfoPower < ActiveRecord::Base
  belongs_to :position_info
  belongs_to :has_position_info,:class_name => "PositionInfo",:foreign_key => "has_position_info_id"
end
