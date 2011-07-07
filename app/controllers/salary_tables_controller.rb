class SalaryTablesController < BaseController
  def new
    @salary_table = SalaryTable.new_with_mth(params[:search][:mth])
  end
end
