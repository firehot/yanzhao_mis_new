module AllInvoiceReceiptsHelper
  #根据票据类型返回票据名称
  def invoice_name(type)
    invoice_types = {
      "ComputerInvoiceReceipt" => "机打运单",
      "HandInvoiceReceipt" => "手工运单",
      "CommonInvoiceReceipt" => "其他票据",
      "ComputerInvoiceShippment" => "机打运单",
      "HandInvoiceShippment" => "手工运单",
      "CommonInvoiceShippment" => "其他票据"
    }
    invoice_types[type]
  end
end
