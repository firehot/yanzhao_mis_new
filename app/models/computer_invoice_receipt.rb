class ComputerInvoiceReceipt < MaterialInout
  default_value_for :warehouse do
    Warehouse.default_invoice_warehouse
  end
end
