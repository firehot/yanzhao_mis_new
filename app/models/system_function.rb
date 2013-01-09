#coding: utf-8
#系统功能表
class SystemFunction < ActiveRecord::Base
  belongs_to :system_function_cat
  validates_presence_of :func_name,:func_key
end
