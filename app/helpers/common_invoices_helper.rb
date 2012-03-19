module CommonInvoicesHelper
  #所有部门/分理处/分公司选择
  def common_invoices_for_select
    CommonInvoice.all(:conditions => {:is_active => true},:order => "name").collect { |i| [i.name, i.id] }
  end

end
