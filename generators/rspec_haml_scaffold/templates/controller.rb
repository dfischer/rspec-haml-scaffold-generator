class <%= controller_class_name %>Controller < ApplicationController
  # GET /<%= name %>
  # GET /<%= name %>.xml
  def index
    @<%= plural_name %> = <%= singular_name.capitalize %>.find(:all)

    respond_to do |format|
      format.html # index.haml
      format.xml  { render :xml => @<%= plural_name %> }
    end
  end

  # GET /<%= name %>/1
  # GET /<%= name %>/1.xml
  def show
    @<%= singular_name %> = <%= singular_name.capitalize %>.find(params[:id])

    respond_to do |format|
      format.html # show.haml
      format.xml  { render :xml => @<%= singular_name %> }
    end
  end

  # GET /<%= name %>/new
  # GET /<%= name %>/new.xml
  def new
    @<%= singular_name %> = <%= singular_name.capitalize %>.new

    respond_to do |format|
      format.html # new.haml
      format.xml  { render :xml => @<%= singular_name %> }
    end
  end

  # GET /<%= name %>/1/edit
  def edit
    @<%= singular_name %> = <%= singular_name.capitalize %>.find(params[:id])
  end

  # POST /<%= name %>
  # POST /<%= name %>.xml
  def create
    @<%= file_name %> = <%= singular_name.capitalize %>.new(params[:<%= singular_name %>])

    respond_to do |format|
      if @<%= file_name %>.save
        flash[:notice] = '<%= singular_name.capitalize %> was successfully created.'
        format.html { redirect_to(<%= table_name.singularize %>_path(@<%= file_name %>)) }
        format.xml  { render :xml => @<%= file_name %>, :status => :created, :location => @<%= file_name %> }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @<%= file_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /<%= name %>/1
  # PUT /<%= name %>/1.xml
  def update
    @<%= file_name %> = <%= singular_name.capitalize %>.find(params[:id])

    respond_to do |format|
      if @<%= file_name %>.update_attributes(params[:<%= file_name %>])
        flash[:notice] = '<%= singular_name.capitalize %> was successfully updated.'
        format.html { redirect_to(<%= table_name.singularize %>_path(@<%= file_name %>)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @<%= file_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /<%= name %>/1
  # DELETE /<%= name %>/1.xml
  def destroy
    @<%= file_name %> = <%= singular_name.capitalize %>.find(params[:id])
    @<%= file_name %>.destroy

    respond_to do |format|
      format.html { redirect_to(<%= table_name %>_url) }
      format.xml  { head :ok }
    end
  end
end
