class SalaryTablesController < BaseController
  skip_filter :create_search
  def new
    #先查找当月工资表是否存在
    if SalaryTable.exists?(:mth => params[:search][:mth])
      flash[:notice] = "#{params[:search][:mth]}工资表已存在."
      @salary_tables = SalaryTable.search(params[:search]).order("mth DESC").paginate :page => params[:page]
      render :action => :index
    else
      @salary_table = SalaryTable.new_with_mth(params[:search][:mth])
    end
  end
  def index
    @salary_tables = SalaryTable.search(params[:search]).order("mth DESC").paginate :page => params[:page]
  end
  #出勤统计
  def index_sum
    @salary_table_lines = SalaryTableLine.search(params[:search]).order("salary_tables.mth DESC").paginate :page => params[:page]
    @salary_table_lines_group = @salary_table_lines.group_by(&:employee)
  end
  #审核
  #PUT salary_tables/1/audit
  def audit
    @salary_table = SalaryTable.find(params[:id])
    if @salary_table.audit
      flash[:notice] = "审核工资表成功."
    else
      flash[:error] = "审核工资表失败."
    end
    render :show
  end
  def edit
    @salary_table = SalaryTable.find(params[:id])
    Employee.find(:all,:conditions => {:is_active => true},:order => "order_by").each do |e|
      @salary_table.salary_table_lines.build(:employee => e) unless @salary_table.employees.include?(e)
    end
  end

end
