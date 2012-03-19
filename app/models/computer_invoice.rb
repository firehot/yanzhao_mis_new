#机打运单
class ComputerInvoice < Material
  default_value_for :unit,"份"
  #获取或创建默认机打运单
  def self.default_computer_invoice
    self.find_or_create_by_name("机打运单票据")
  end
end
