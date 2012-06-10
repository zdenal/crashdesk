class ErrorsController < ApplicationController

  respond_to :json, :html

  def index
    session[:app_key] ||= Bucket.first.name
    @errors = Error.find(:all, params: { app_key: session[:app_key] })
    respond_with @errors
  end

  def show
    @error = Error.find(params[:id], params: { app_key: session[:app_key] })
    respond_with @error.as_json
  end

  def update
    @error = Error.find(params[:id], params: { app_key: session[:app_key] })
    #@error.update_attributes params[:error]
    @error.update_attribute 'title', 'a'
    respond_with status: :ok
    #respond_with Error.update params[:id], params[:app]
  end

  def destroy
    #respond_with Error.destroy params[:id]
    respond_with status: :ok
  end

end

