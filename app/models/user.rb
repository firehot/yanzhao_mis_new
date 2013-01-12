class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :http_authenticatable, :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable,:rememberable,:registerable
  #:confirmable, :recoverable,:registerable,:rememberable, :trackable, :validatable

  belongs_to :org
  has_many :powers
  has_many :system_functions,:through => :powers

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :password, :password_confirmation,:is_admin,:is_active,:org_id,:remember_me,:powers_attributes,:level
  accepts_nested_attributes_for :powers
  #获取分组的system_functions
  def grouped_system_function_cats
    cat_ids = []
    self.powers.each {|p| cat_ids += [p.system_function.system_function_cat.id] if p.is_select and p.system_function.try(:system_function_cat) }
    cat_ids.uniq!
    sf_cats = SystemFunctionCat.find(cat_ids,:order => "order_by ASC")
    grouped_sf_cat = sf_cats.group_by {|sf_cat| sf_cat.system_function_group}
  end
end
