#手工运单
class HandInvoice < Material
  default_value_for :unit,"份"
  #获取或创建默认的手工运单
  def self.default_hand_invoice
    self.find_or_create_by_name("手工运单票据")
  end
end
