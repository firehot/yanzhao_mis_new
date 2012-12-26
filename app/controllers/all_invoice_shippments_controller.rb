#coding: utf-8
#所有出库票据
class AllInvoiceShippmentsController < ApplicationController
  #GET all_invoice_receipts
  #获取所有票据收货单据
  #包括以下单据:机打运单/手工运单/其他运单
  def index
    @all_invoice_shippments = MaterialInout.type_eq(['ComputerInvoiceShippment','HandInvoiceShippment','CommonInvoiceShippment']).search(params[:search]).paginate :page => params[:page],:order => "created_at DESC"
    @all_invoice_shippments_group = @all_invoice_shippments.group_by {|i| i['type']}
  end

end
