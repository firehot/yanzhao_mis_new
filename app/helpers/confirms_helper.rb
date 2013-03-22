module ConfirmsHelper
  def bill_operate_state_desc(state)
    "待确认" if state.eql?('DR')
    "已确认" if state.eql?('CO')
    "已审核" if state.eql?('OK')
  end
end
