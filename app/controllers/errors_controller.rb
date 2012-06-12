class ErrorsController < ApplicationController

  respond_to :json, :html

  def index
    session[:app_id] ||= Bucket.last.name
    @errors = Error.find(:all, params: { app_id: session[:app_id] })
    respond_with @errors
  end

  def show
    @error = Error.find(params[:id], params: { app_id: session[:app_id] })
    respond_with @error.as_json
  end

  def update
    @error = Error.find(params[:id], params: { app_id: session[:app_id] })
    @error.load params[:error]
    @error.prefix_options = {app_id: session[:app_id]}
    @error.save
    respond_with status: :ok
  end

  def destroy
    respond_with Error.destroy params[:id]
    respond_with status: :ok
  end

end

