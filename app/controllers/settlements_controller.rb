class SettlementsController < BaseController
  # GET /settlements
  def index
    @settlements = @search.paginate :page => params[:page],:order => "created_at DESC,org_id,mth DESC"
    @group_settlements = @settlements.group_by(&:org)
    @sum_info = {
      :start_push_money => @search.sum(:start_push_money),
      :back_push_money=> @search.sum(:back_push_money),
      :total_push_money=> @search.sum(:total_push_money),
      :total_subsidy=> @search.sum(:total_subsidy),
      :total_deduction=> @search.sum(:total_deduction),
      :total_push_money=> @search.sum(:total_push_money)
    }
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @settlements }
    end

  end

  # GET /settlements/new.xml
  def new
    #先判断是否已存在结算信息
    if @search.count > 0
      flash[:notice] = "结算表已存在,转向修改界面."
      @settlement = @search.first 
      render :edit
    else
      @settlement = Settlement.new(:org_id => params[:search][:org_id_is],:mth => params[:search][:mth_is])
      #查找有无对应的合同模板
      #将月份转换为日期
      first_day = "#{params[:search][:mth_is]}01".to_date.beginning_of_month
      last_day = "#{params[:search][:mth_is]}01".to_date.end_of_month
      #查找有无对应日期的合同模板
      contracts = Contract.org_id_is(params[:search][:org_id_is]).date_from_lte(first_day).date_to_gte(last_day)
      if contracts.blank?
        flash[:error] = "未找到符合条件的合同模板."
        redirect_to :back 
      else
        @settlement.build_lines(contracts.first,params[:search][:mth_is])
      end
    end
  end

  #GET /settlements/1
  def show
    @settlement = Settlement.find(params[:id])

    respond_to do |format|
      format.html { render :show,:layout => false }
      format.xml  { render :xml => the_model }
    end
  end


  # POST /settlements
  # POST /settlements.xml
  def create
    @settlement = Settlement.new(params[:settlement])

    respond_to do |format|
      if @settlement.save
        flash[:notice] = 'Settlement was successfully created.'
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @settlement, :status => :created, :location => @settlement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @settlement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /settlements/1
  # PUT /settlements/1.xml
  def update
    @settlement = Settlement.find(params[:id])

    respond_to do |format|
      if @settlement.update_attributes(params[:settlement])
        flash[:notice] = 'Settlement was successfully updated.'
        format.html { redirect_to :action => :index }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @settlement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /settlements/1
  # DELETE /settlements/1.xml
  def destroy
    @settlement = Settlement.find(params[:id])
    @settlement.destroy

    respond_to do |format|
      format.html { redirect_to(settlements_url) }
      format.xml  { head :ok }
    end
  end
end