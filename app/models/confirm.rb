class Confirm < ActiveRecord::Base
  belongs_to :user
  belongs_to :auditor,:class_name => "User",:foreign_key => :auditor_id
  has_many :bills


  def audit(auditor_id)
    Bill.update_all("state = 'CO_AD'",{:id => self.bill_ids})
    self.update_attributes(:auditor_id => auditor_id,:audit_date => DateTime.now,:state => "OK") if self.state.eql?('DR')
  end
end
