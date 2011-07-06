class PunishmentsController < BaseController
  def new
    if params[:violation_id].blank?
      @punishment = Punishment.new
    else
      @punishment = Punishment.new_with_violation(Violation.find(params[:violation_id]))
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @violation }
    end
  end
  def show
    @punishment = Punishment.find(params[:id])
    respond_to do |format|
      format.html
      format.js {render :partial => "show"}
    end
  end
  #导出excel
  def export_excel
    @punishment = Punishment.find(params[:id])
    respond_to do |format|
      format.html
      format.js {render :partial => "export_excel"}
    end

  end
end
