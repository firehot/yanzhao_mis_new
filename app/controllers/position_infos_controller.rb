#coding: utf-8
#职位信息
class PositionInfosController < BaseController
  #GET org_infos/:org_info_id/position_infos
  def index
    #获取根目录
    level = params[:level]
    level ||= 'corporation'
    @root_position_info = PositionInfo.get_root(level)
    @position_info = @root_position_info
    respond_to do |format|
      format.html do
        unless @root_position_info
          @root_position_info ||= PositionInfo.new
          @position_info = @root_position_info
          render :action => :new
        end
      end
      format.xml  { render :xml => @root_position_info }
    end
  end
  #GET org_infos/:org_info_id/position_infos/new
  def new
    @position_info = PositionInfo.new(params[:position_info])
    #@position_info.org_info_id = params[:org_info_id]
  end
  #PUT org_infos/:org_info_id/position_infos/:position_info_id
  def update
    @position_info = PositionInfo.find(params[:id])
    respond_to do |format|
      if @position_info.update_attributes(params[:position_info])
        flash[:notice] = "职位信息更新成功."
        format.html { redirect_to :back }
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
        format.html { redirect_to :back}
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
