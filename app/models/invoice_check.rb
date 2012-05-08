class InvoiceCheck < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  default_value_for :check_date do
    Date.today
  end
  #电脑票剩余数量
  def computer_rest_count
    self.computer_balance_count + self.computer_receive_count - self.computer_used_count - computer_invalid_count
  end
  #手工票剩余数量
  def hand_rest_count
    self.hand_balance_count + self.hand_receive_count - self.hand_used_count - hand_invalid_count
  end
  #NOTE 手工票需要按照x本x份显示
  def hand_balance_count_display
    ret = self.hand_balance_count.divmod(HandInvoice.default_hand_invoice.package_volume)
    if ret.first == 0
      "#{ret.last}份"
    else
      "#{ret.first}本零#{ret.last}份"
    end
  end
  def hand_rest_count_display
    ret = self.hand_rest_count.divmod(HandInvoice.default_hand_invoice.package_volume)
    if ret.first == 0
      "#{ret.last}份"
    else
      "#{ret.first}本零#{ret.last}份"
    end
  end
  #手工票本期领用
  def hand_receive_count_display
    ret = self.hand_receive_count.divmod(HandInvoice.default_hand_invoice.package_volume)
    if ret.first == 0
      "#{ret.last}份"
    else
      "#{ret.first}本#{ret.last}份"
    end
  end
  #新建
  def self.new_with_org(org)
    invoice_check = self.new(:org => org)
    #获取最近一次盘查记录
    last_invoice_check = InvoiceCheck.first(:conditions => {:org_id => org.id},:order => "check_date DESC")
    invoice_check.computer_balance_count = last_invoice_check.computer_rest_count if last_invoice_check
    invoice_check.hand_balance_count = last_invoice_check.hand_rest_count if last_invoice_check
    #计算最近一段领取数量
    start_date = '1909-01-01'
    start_date = last_invoice_check.check_date if last_invoice_check
    end_date = Date.today
    invoice_check.computer_receive_count = MaterialInoutLine.search(:material_inout_inout_date_gt => start_date,:material_inout_inout_date_lte => end_date,:material_inout_org_id_is => org.id,:material_id_is => ComputerInvoice.default_computer_invoice.id).sum(:qty)
    invoice_check.hand_receive_count = MaterialInoutLine.search(:material_inout_inout_date_gt => start_date,:material_inout_inout_date_lte => end_date,:material_inout_org_id_is => org.id,:material_id_is => HandInvoice.default_hand_invoice.id).sum(:qty)
    invoice_check
  end
end
