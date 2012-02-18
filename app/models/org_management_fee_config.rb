class OrgManagementFeeConfig < ActiveRecord::Base
  belongs_to :org
  validates_numericality_of :rent_fee,:office_fee,:distance,:goods_loaded,:fuel_fee
end
