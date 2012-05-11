class HandInvoiceShippmentsController < MaterialInoutsController
  #显示单据审核界面
  #GET hand_invoice_shippment/:id/show_confirm
  def show_confirm
    @hand_invoice_shippment = HandInvoiceShippment.find(params[:id])
  end
  #票据确认操作
  #PUT hand_invoice_shippment/:id/confirm
  def confirm
    @hand_invoice_shippment = HandInvoiceShippment.find(params[:id])
    @hand_invoice_shippment.update_attributes(params[:hand_invoice_shippment])
    @hand_invoice_shippment.confirm(current_user)
    flash[:notice] = '单据审核成功.'
    redirect_to @hand_invoice_shippment
  end
end
