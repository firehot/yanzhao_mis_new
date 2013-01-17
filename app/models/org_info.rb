#coding: utf-8
#机构信息表
class OrgInfo < ActiveRecord::Base
  has_many :children,:class_name => "OrgInfo",:foreign_key => "parent_id",:order => "order_by"
  has_many :position_infos
end
