#coding: utf-8
#职位信息
class PositionInfosController < BaseController
  #GET org_infos/:org_info_id/position_infos
  def index
    #获取根目录
    @root_position_info = PositionInfo.find_by_org_info_id_and_parent_id(params[:org_info_id],nil)
    @position_info = @root_position_info

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @root_position_info }
    end
  end
  #GET org_infos/:org_info_id/position_infos/new
  def new
    @position_info = PositionInfo.new(params[:position_info])
    @position_info.org_info_id = params[:org_info_id]
  end
  #PUT org_infos/:org_info_id/position_infos/:position_info_id
  def update
    @position_info = PositionInfo.find(params[:id])
    respond_to do |format|
      if @position_info.update_attributes(params[:position_info])
        flash[:notice] = "职位信息更新成功."
        format.html { redirect_to(org_info_position_infos_path(@position_info.org_info,:active_sub_tab => 4)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @position_info.errors, :status => :unprocessable_entity }
      end
    end


  end
  #POST org_infos/:org_info_id/position_infos
  def create
     @position_info= PositionInfo.new(params[:position_info])
    respond_to do |format|
      if @position_info.save
        flash[:notice] = "职位信息保存成功."
        format.html { redirect_to(org_info_position_infos_path(@position_info.org_info,:active_sub_tab => 4)) }
        format.xml  { render :xml => @position_info, :status => :created, :location => @position_info }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @position_info.errors, :status => :unprocessable_entity }
      end
    end
  end
  # DELETE /the_models/1
  # DELETE /the_models/1.xml
  def destroy
    @position_info = PositionInfo.find(params[:id])
    @position_info.destroy

    flash[:notice] = "职位信息已被删除."
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
end
