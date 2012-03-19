#手工运单入库单
class HandInvoiceReceipt < MaterialInout
  default_value_for :warehouse do
    Warehouse.default_invoice_warehouse
  end
end
