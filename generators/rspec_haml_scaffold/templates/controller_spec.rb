require File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../spec_helper'

describe <%= controller_class_name %>Controller, "#route_for" do

  it "should map { :controller => '<%= name.pluralize %>', :action => 'index' } to /<%= name.pluralize %>" do
    route_for(:controller => "<%= name.pluralize %>", :action => "index").should == "/<%= name.pluralize %>"
  end
  
  it "should map { :controller => '<%= name.pluralize %>', :action => 'new' } to /<%= name.pluralize %>/new" do
    route_for(:controller => "<%= name.pluralize %>", :action => "new").should == "/<%= name.pluralize %>/new"
  end
  
  it "should map { :controller => '<%= name.pluralize %>', :action => 'show', :id => 1 } to /<%= name.pluralize %>/1" do
    route_for(:controller => "<%= name.pluralize %>", :action => "show", :id => 1).should == "/<%= name.pluralize %>/1"
  end
  
  it "should map { :controller => '<%= name.pluralize %>', :action => 'edit', :id => 1 } to /<%= name.pluralize %>/1<%= resource_edit_path %>" do
    route_for(:controller => "<%= name.pluralize %>", :action => "edit", :id => 1).should == "/<%= name.pluralize %>/1<%= resource_edit_path %>"
  end
  
  it "should map { :controller => '<%= name.pluralize %>', :action => 'update', :id => 1} to /<%= name.pluralize %>/1" do
    route_for(:controller => "<%= name.pluralize %>", :action => "update", :id => 1).should == "/<%= name.pluralize %>/1"
  end
  
  it "should map { :controller => '<%= name.pluralize %>', :action => 'destroy', :id => 1} to /<%= name.pluralize %>/1" do
    route_for(:controller => "<%= name.pluralize %>", :action => "destroy", :id => 1).should == "/<%= name.pluralize %>/1"
  end
  
end

describe <%= controller_class_name %>Controller, "handling GET /<%= name.pluralize %>" do

  before do
    @<%= file_name %> = mock_model(<%= singular_name.capitalize %>)
    <%= singular_name.capitalize %>.stub!(:find).and_return([@<%= file_name %>])
  end
  
  def do_get
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should render index template" do
    do_get
    response.should render_template('index')
  end
  
  it "should find all <%= name.pluralize %>" do
    <%= singular_name.capitalize %>.should_receive(:find).with(:all).and_return([@<%= file_name %>])
    do_get
  end
  
  it "should assign the found <%= name.pluralize %> for the view" do
    do_get
    assigns[:<%= singular_name.pluralize %>].should == [@<%= file_name %>]
  end
end

describe <%= controller_class_name %>Controller, "handling GET /<%= name.pluralize %>.xml" do

  before do
    @<%= file_name %> = mock_model(<%= singular_name.capitalize %>, :to_xml => "XML")
    <%= singular_name.capitalize %>.stub!(:find).and_return(@<%= file_name %>)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should find all <%= name.pluralize %>" do
    <%= singular_name.capitalize %>.should_receive(:find).with(:all).and_return([@<%= file_name %>])
    do_get
  end
  
  it "should render the found <%= name %> as xml" do
    @<%= file_name %>.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe <%= controller_class_name %>Controller, "handling GET /<%= name.pluralize %>/1" do

  before do
    @<%= file_name %> = mock_model(<%= singular_name.capitalize %>)
    <%= singular_name.capitalize %>.stub!(:find).and_return(@<%= file_name %>)
  end
  
  def do_get
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render show template" do
    do_get
    response.should render_template('show')
  end
  
  it "should find the <%= file_name %> requested" do
    <%= singular_name.capitalize %>.should_receive(:find).with("1").and_return(@<%= file_name %>)
    do_get
  end
  
  it "should assign the found <%= file_name %> for the view" do
    do_get
    assigns[:<%= file_name %>].should equal(@<%= file_name %>)
  end
end

describe <%= controller_class_name %>Controller, "handling GET /<%= name.pluralize %>/1.xml" do

  before do
    @<%= file_name %> = mock_model(<%= singular_name.capitalize %>, :to_xml => "XML")
    <%= singular_name.capitalize %>.stub!(:find).and_return(@<%= file_name %>)
  end
  
  def do_get
    @request.env["HTTP_ACCEPT"] = "application/xml"
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should find the <%= file_name %> requested" do
    <%= singular_name.capitalize %>.should_receive(:find).with("1").and_return(@<%= file_name %>)
    do_get
  end
  
  it "should render the found <%= file_name %> as xml" do
    @<%= singular_name %>.should_receive(:to_xml).and_return("XML")
    do_get
    response.body.should == "XML"
  end
end

describe <%= controller_class_name %>Controller, "handling GET /<%= name.pluralize %>/new" do

  before do
    @<%= file_name %> = mock_model(<%= singular_name.capitalize %>)
    <%= singular_name.capitalize %>.stub!(:new).and_return(@<%= file_name %>)
  end
  
  def do_get
    get :new
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render new template" do
    do_get
    response.should render_template('new')
  end
  
  it "should create an new <%= file_name %>" do
    <%= singular_name.capitalize %>.should_receive(:new).and_return(@<%= file_name %>)
    do_get
  end
  
  it "should not save the new <%= file_name %>" do
    @<%= file_name %>.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new <%= file_name %> for the view" do
    do_get
    assigns[:<%= file_name %>].should equal(@<%= file_name %>)
  end
end

describe <%= controller_class_name %>Controller, "handling GET /<%= name.pluralize %>/1/edit" do

  before do
    @<%= file_name %> = mock_model(<%= singular_name.capitalize %>)
    <%= singular_name.capitalize %>.stub!(:find).and_return(@<%= file_name %>)
  end
  
  def do_get
    get :edit, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render edit template" do
    do_get
    response.should render_template('edit')
  end
  
  it "should find the <%= file_name %> requested" do
    <%= singular_name.capitalize %>.should_receive(:find).and_return(@<%= file_name %>)
    do_get
  end
  
  it "should assign the found <%= file_name %> for the view" do
    do_get
    assigns[:<%= file_name %>].should equal(@<%= file_name %>)
  end
end

describe <%= controller_class_name %>Controller, "handling POST /<%= name.pluralize %>" do

  before do
    @<%= file_name %> = mock_model(<%= singular_name.capitalize %>, :to_param => "1")
    <%= singular_name.capitalize %>.stub!(:new).and_return(@<%= file_name %>)
  end
  
  def post_with_successful_save
    @<%= file_name %>.should_receive(:save).and_return(true)
    post :create, :<%= file_name %> => {}
  end
  
  def post_with_failed_save
    @<%= file_name %>.should_receive(:save).and_return(false)
    post :create, :<%= file_name %> => {}
  end
  
  it "should create a new <%= file_name %>" do
    <%= singular_name.capitalize %>.should_receive(:new).with({}).and_return(@<%= file_name %>)
    post_with_successful_save
  end

  it "should redirect to the new <%= file_name %> on successful save" do
    post_with_successful_save
    response.should redirect_to(<%= table_name.singularize %>_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe <%= controller_class_name %>Controller, "handling PUT /<%= name.pluralize %>/1" do

  before do
    @<%= file_name %> = mock_model(<%= singular_name.capitalize %>, :to_param => "1")
    <%= singular_name.capitalize %>.stub!(:find).and_return(@<%= file_name %>)
  end
  
  def put_with_successful_update
    @<%= file_name %>.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @<%= file_name %>.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the <%= file_name %> requested" do
    <%= singular_name.capitalize %>.should_receive(:find).with("1").and_return(@<%= file_name %>)
    put_with_successful_update
  end

  it "should update the found <%= file_name %>" do
    put_with_successful_update
    assigns(:<%= file_name %>).should equal(@<%= file_name %>)
  end

  it "should assign the found <%= file_name %> for the view" do
    put_with_successful_update
    assigns(:<%= file_name %>).should equal(@<%= file_name %>)
  end

  it "should redirect to the <%= file_name %> on successful update" do
    put_with_successful_update
    response.should redirect_to(<%= table_name.singularize %>_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe <%= controller_class_name %>Controller, "handling DELETE /<%= name %>/1" do

  before do
    @<%= file_name %> = mock_model(<%= singular_name.capitalize %>, :destroy => true)
    <%= singular_name.capitalize %>.stub!(:find).and_return(@<%= file_name %>)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end

  it "should find the <%= file_name %> requested" do
    <%= singular_name.capitalize %>.should_receive(:find).with("1").and_return(@<%= file_name %>)
    do_delete
  end
  
  it "should call destroy on the found <%= file_name %>" do
    @<%= file_name %>.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the <%= name.pluralize %> list" do
    do_delete
    response.should redirect_to(<%= table_name.pluralize %>_url)
  end
end
