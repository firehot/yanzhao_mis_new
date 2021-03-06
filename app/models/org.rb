class Org < ActiveRecord::Base
  belongs_to :user
  has_many :users
  validates_presence_of :name,:message => "名称不可为空"
  #只返回具有给定权限的user列表
  def users_by_power(func_key)
    ret_users = self.users.is_active_is(true).powers_is_select_is(true).powers_system_function_func_key_is(func_key)
    ret_users.uniq
  end

  #去除董事长级别
  def user_except_level(levels)
    ret_users = self.users.is_active_is(true).all
    except_levels = levels.split(',')
    ret = ret_users.select {|user| not except_levels.include?(user.level.to_s)}
    ret.uniq
  end
end
