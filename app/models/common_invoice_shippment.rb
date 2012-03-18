class CommonInvoiceShippment <  MaterialInout
  #设置票据默认仓库为系统默认的票据仓库
  default_value_for :warehouse do
    Warehouse.default_invoice_warehouse
  end
end
