#coding: utf-8
#系统功能分类表
class SystemFunctionCat < ActiveRecord::Base
  has_many :system_functions
  belongs_to :system_function_group
  validates_presence_of :cat_name
end
