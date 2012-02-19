class BudgetTablesController < BaseController
  #GET budget_tables/new
  def new
    if params[:budget_table].blank? or ManagementFeeConfig.count == 0 or !OrgManagementFeeConfig.exists?(:org_id => params[:budget_table][:org_id])
      flash[:error] = "请先设置计算比例和费用信息后,再进行预算操作."
      redirect_to :back
    else
      @budget_table = BudgetTable.new_with_org_id_and_sum_carrying_fee(params[:budget_table][:org_id],params[:budget_table][:sum_carrying_fee])
    end
  end
end
