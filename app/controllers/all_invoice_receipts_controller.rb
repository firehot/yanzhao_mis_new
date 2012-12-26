#coding: utf-8
#所有票据收货单据
class AllInvoiceReceiptsController < ApplicationController
  #GET all_invoice_receipts
  #获取所有票据收货单据
  #包括以下单据:机打运单/手工运单/其他运单
  def index
    @all_invoice_receipts = MaterialInout.type_eq(['ComputerInvoiceReceipt','HandInvoiceReceipt','CommonInvoiceReceipt']).search(params[:search]).paginate :page => params[:page],:order => "created_at DESC"
    @all_invoice_receipts_group = @all_invoice_receipts.group_by {|i| i['type']}
  end
end
