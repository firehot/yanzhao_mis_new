#coding: utf-8
#职位子条目
class PositionInfoItemsController < BaseController
  #GET org_infos/:org_info_id/position_infos
  def index
    @position_info_items = PositionInfo.find(params[:position_info_id]).position_info_items
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @position_info_items }
    end
  end
  #GET org_infos/:org_info_id/position_info_items/new
  def new
    @position_info_item = PositionInfoItem.new(params[:position_info_item])
    @position_info_item.position_info_id = params[:position_info_id]
  end
  #PUT org_infos/:org_info_id/position_info_items/:position_info_item_id
  def update
    @position_info_item = PositionInfoItem.find(params[:id])
    respond_to do |format|
      if @position_info_item.update_attributes(params[:position_info_item])
        flash[:notice] = "职位信息更新成功."
        format.html { redirect_to(position_info_position_info_items_path(@position_info_item.position_info,:active_sub_tab => 8)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @position_info_item.errors, :status => :unprocessable_entity }
      end
    end


  end
  #POST org_infos/:org_info_id/position_info_items
  def create
     @position_info_item= PositionInfoItem.new(params[:position_info_item])
    respond_to do |format|
      if @position_info_item.save
        flash[:notice] = "职位条目保存成功."
        format.html { redirect_to(position_info_position_info_items_path(@position_info_item.position_info,:active_sub_tab => 8)) }
        format.xml  { render :xml => @position_info_item, :status => :created, :location => @position_info_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @position_info_item.errors, :status => :unprocessable_entity }
      end
    end
  end
  # DELETE /the_models/1
  # DELETE /the_models/1.xml
  def destroy
    @position_info_item = PositionInfoItem.find(params[:id])
    @position_info_item.destroy

    flash[:notice] = "职位条目已被删除."
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end

end
