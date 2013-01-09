#系统功能分组
class SystemFunctionGroup < ActiveRecord::Base
  has_many :system_function_cats
  validates_presence_of :group_name
end
