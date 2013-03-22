module PostInfosHelper
  def post_info_state_desc(state)
    ret = ""
    ret = "已核销" if state.eql?('DR') or state.eql?('PO')
    ret = "已审核" if state.eql?('OK')
    ret
  end

end
