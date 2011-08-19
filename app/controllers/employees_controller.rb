class EmployeesController < BaseController
  def index
    @employees = @search.paginate :page => params[:page],:order => "code ASC"
  end
end
