#coding: utf-8
#内容条目管理器
class ContentItemsController < BaseController
  #GET content_items
  def index
    @content_items = ContentItem.content_class_code_eq(params[:content_class_code]).search(params[:search]).paginate :page => params[:page],:order => "created_at DESC"
  end
  #GET content_items/first
  #获取第一个条目信息
  def first
    @content_item = ContentItem.content_class_code_eq(params[:content_class_code]).try(:first)
  end
  #GET content_items/new
  def new
    content_class = ContentClass.find_by_code(params[:content_class_code])
    @content_item = ContentItem.new(:content_class_id => content_class.id)
  end
  # POST /the_models
  # POST /the_models.xml
  def create
    @content_item = ContentItem.new(params[:content_item])

    respond_to do |format|
      if @content_item.save
        flash[:notice] = "信息保存成功."
        format.html { redirect_to(:action => :index,:content_class_code => params[:content_class_code])}
        format.xml  { render :xml => @content_item, :status => :created, :location => @content_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @content_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /the_models/1
  # PUT /the_models/1.xml
  def update
    @content_item = ContentItem.find(params[:id])
    respond_to do |format|
      if @content_item.update_attributes(params[:content_item])
        flash[:notice] = "信息更新成功."
        format.html { redirect_to(:action => :index,:content_class_code => params[:content_class_code]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @content_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /the_models/1
  # DELETE /the_models/1.xml
  def destroy
    @content_item = ContentItem.find(params[:id])
    @content_item.destroy

    flash[:notice] = "信息已被删除."
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
end
