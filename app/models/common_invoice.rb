#普通票据
class CommonInvoice < Material
  belongs_to :invoice_type
  validates_numericality_of :unit_price,:message => "单价应为数字"
end
