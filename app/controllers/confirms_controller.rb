class ConfirmsController < BillOperateController
  #确认后审核
  #PUT confirms/:id/audit
  def audit
    @confirm = Confirm.find(params[:id])
    if @confirm.audit(current_user.id)
      flash[:success] = "审核数据成功!"
    else
      flash[:error] = "审核数据失败!"
    end
    render :action => :show
  end
  protected
  #根据当前操作的类型得到操作后票据的状态,在子类中覆盖
  def after_state
    Bill::STATE_CONFIRM
  end
end
