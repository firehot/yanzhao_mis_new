module ConfirmsHelper
  def confirm_state_desc(state)
    ret = ""
    ret = "待确认" if state.eql?('DR') or state.eql?('CO')
    ret = "已审核" if state.eql?('OK')
    ret
  end
end
