class Client < ActiveRecord::Base
  validates_presence_of :name,:message => "注册名称不可为空."
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "50x50>" }
  #机构和用户
  def admin
    User.new(:is_admin => true,:org_id => 1)
  end
  
  def orgs
    [SubCompany.new,SubCompany.new]
  end

  def admin_attributes=(attributes)
    User.create(attributes)
  end
  def orgs_attributes=(attributes)
    attributes.values.each do |attrs|
      SubCompany.create(attrs)
    end
  end
end
