#机打运单
class ComputerInvoice < Material
  #获取或创建默认机打运单
  def self.default_computer_invoice
    self.find_or_create_by_name_and_unit_and_unit_price_and_min_count("机打运单票据","份",0.01,100)
  end
end
