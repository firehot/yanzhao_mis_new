class InvoiceTypesController < ApplicationController
  # GET /invoice_types
  # GET /invoice_types.xml
  def index
    @invoice_types = InvoiceType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invoice_types }
    end
  end

  # GET /invoice_types/1
  # GET /invoice_types/1.xml
  def show
    @invoice_type = InvoiceType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice_type }
    end
  end

  # GET /invoice_types/new
  # GET /invoice_types/new.xml
  def new
    @invoice_type = InvoiceType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invoice_type }
    end
  end

  # GET /invoice_types/1/edit
  def edit
    @invoice_type = InvoiceType.find(params[:id])
  end

  # POST /invoice_types
  # POST /invoice_types.xml
  def create
    @invoice_type = InvoiceType.new(params[:invoice_type])

    respond_to do |format|
      if @invoice_type.save
        flash[:notice] = 'InvoiceType was successfully created.'
        format.html { redirect_to(@invoice_type) }
        format.xml  { render :xml => @invoice_type, :status => :created, :location => @invoice_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invoice_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invoice_types/1
  # PUT /invoice_types/1.xml
  def update
    @invoice_type = InvoiceType.find(params[:id])

    respond_to do |format|
      if @invoice_type.update_attributes(params[:invoice_type])
        flash[:notice] = 'InvoiceType was successfully updated.'
        format.html { redirect_to(@invoice_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invoice_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invoice_types/1
  # DELETE /invoice_types/1.xml
  def destroy
    @invoice_type = InvoiceType.find(params[:id])
    @invoice_type.destroy

    respond_to do |format|
      format.html { redirect_to(invoice_types_url) }
      format.xml  { head :ok }
    end
  end
end
