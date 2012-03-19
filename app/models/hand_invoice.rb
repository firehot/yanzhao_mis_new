#手工运单
class HandInvoice < Material
  #获取或创建默认的手工运单
  def self.default_hand_invoice
    self.find_or_create_by_name_and_unit_and_unit_price_and_min_count("手工运单票据","份",0.01,100)
  end
end
