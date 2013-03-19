module ConfirmsHelper
  def bill_operate_state_desc(state)
    "待审核" if state.eql?('DR')
    "已审核" if state.eql?('OK')
  end
end
