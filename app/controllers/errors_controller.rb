class ErrorsController < ApplicationController

  respond_to :json, :html

  def index
    #Crashdesk::Services::CreateFakedErrorsService.new.fill_db
    @errors = App.last.errors
    respond_with @errors
  end

  def show
    @error = Error.find(params[:id])
    respond_with @error.as_json
  end

  def update
    @error = Error.find(params[:id])
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

