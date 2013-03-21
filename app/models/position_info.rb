#coding: utf-8
#职位信息表
class PositionInfo < ActiveRecord::Base
  belongs_to :org_info
  belongs_to :parent,:class_name => 'PositionInfo'
  has_many :children,:class_name => "PositionInfo",:foreign_key => "parent_id",:order => "order_by"
  has_many :position_info_items
  #当前职位可查看何种职位的信息
  has_many :position_info_powers,:dependent => :destroy
  validates_presence_of :name

  accepts_nested_attributes_for :position_info_powers,:allow_destroy => true
  default_value_for :is_active,true

  #获取分组的权限信息
  def grouped_position_info_powers
    PositionInfo.all(:conditions => {:is_active => true},:order => "order_by ASC").each do |pi|
      unless self.position_infos.try(:include?,pi)
        self.position_info_powers.build(:has_position_info => pi)
      end
    end
    self.position_info_powers.group_by {|pip| pip.has_position_info.org_info}
  end

  def position_infos
    self.position_info_powers.map {|p| p.has_position_info}
  end

  #根据给定的类别获取根目录
  def self.get_root(level)
    PositionInfo.find_by_name(level).try(:children).try(:first)
  end
end
