class PagesController < ApplicationController
  respond_to :json, :xml

  # automatically look up all of the pages for all member actions
  before_filter :page_by_id,
      :only => [:show, :edit, :update, :destroy, :publish, :total_words]

  # Disable CSRF protection for this RESTful API, for now.  I am not sure if I like this.
  skip_before_filter :verify_authenticity_token

  def index
    respond_with Page.all
  end

  def show
    respond_with @page
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
    @page.update_attributes(params[:page])
    respond_with @page
  end

  def destroy
    @page.destroy
    respond_with @page
  end

  def published
    respond_with Page.published
  end

  def unpublished
    respond_with Page.unpublished
  end

  def publish
    @page.published_on = Time.now
    @page.save
    respond_with @page
  end

  def total_words
    respond_with({ "total_words" => @page.total_words })
  end

  private

  def page_by_id
    @page = Page.find(params[:id])
  end
end
