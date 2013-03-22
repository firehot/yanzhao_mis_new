module ConfirmsHelper
  def bill_operate_state_desc(state)
    ret = ""
    ret = "待确认" if state.eql?('DR')
    ret = "已确认" if state.eql?('CO')
    ret = "已核销" if state.eql?('PO')
    ret = "已审核" if state.eql?('OK')
    ret
  end
end
