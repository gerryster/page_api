class PagesController < ApplicationController
  respond_to :json, :xml

  # Disable CSRF protection for this RESTful API, for now.  I am not sure if I like this.
  skip_before_filter :verify_authenticity_token

  def index
    respond_with Page.all
  end

  def show
    respond_with Page.find(params[:id])
  end

  def new
    respond_with Page.new
  end

  def edit
    show # for the purposes of the API these are identical actions
  end

  def create
    @page = Page.new(params[:page])
    @page.save
    respond_with @page
  end

  def update
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])
    respond_with @page
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    respond_with @page
  end
end
