class Employee < ActiveRecord::Base
  belongs_to :org
  validates_presence_of :name,:org_id,:entry_date
  default_scope :order => "code ASC"
end
