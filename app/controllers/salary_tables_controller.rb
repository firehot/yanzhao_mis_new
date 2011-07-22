class SalaryTablesController < BaseController
  def new
    @salary_table = SalaryTable.new_with_mth(params[:search][:mth])
  end
  def index
    @salary_tables = SalaryTable.search(params[:search]).order("mth DESC").paginate :page => params[:page]
  end
end
