class InvoiceChecksController < BaseController
  #GET invoice_checks/new
  def new
    org = Org.find(params[:invoice_check][:org_id])
    @invoice_check = InvoiceCheck.new_with_org(org)
  end
end
