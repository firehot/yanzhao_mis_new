class PositionInfosController < ApplicationController
  # GET /position_infos
  # GET /position_infos.xml
  def index
    @position_infos = PositionInfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @position_infos }
    end
  end

  # GET /position_infos/1
  # GET /position_infos/1.xml
  def show
    @position_info = PositionInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @position_info }
    end
  end

  # GET /position_infos/new
  # GET /position_infos/new.xml
  def new
    @position_info = PositionInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @position_info }
    end
  end

  # GET /position_infos/1/edit
  def edit
    @position_info = PositionInfo.find(params[:id])
  end

  # POST /position_infos
  # POST /position_infos.xml
  def create
    @position_info = PositionInfo.new(params[:position_info])

    respond_to do |format|
      if @position_info.save
        flash[:notice] = 'PositionInfo was successfully created.'
        format.html { redirect_to(@position_info) }
        format.xml  { render :xml => @position_info, :status => :created, :location => @position_info }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @position_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /position_infos/1
  # PUT /position_infos/1.xml
  def update
    @position_info = PositionInfo.find(params[:id])

    respond_to do |format|
      if @position_info.update_attributes(params[:position_info])
        flash[:notice] = 'PositionInfo was successfully updated.'
        format.html { redirect_to(@position_info) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @position_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /position_infos/1
  # DELETE /position_infos/1.xml
  def destroy
    @position_info = PositionInfo.find(params[:id])
    @position_info.destroy

    respond_to do |format|
      format.html { redirect_to(position_infos_url) }
      format.xml  { head :ok }
    end
  end
end
