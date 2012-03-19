#机打票领用
class ComputerInvoiceShippment < MaterialInout
  default_value_for :warehouse do
    Warehouse.default_invoice_warehouse
  end
end
