class Api::ErrorsController < ApplicationController

  respond_to :json, :html

  def index
    @errors = App.find_by(id: params[:app_key]).error_info
    respond_with @errors
  end

  def show
    @error = Error.find(params[:id])
    respond_with @error.as_json
  end

  def create
    Services::ProcessError.new(params[:error]).run
  end

  def update
    @error = Error.find(params[:id])
    @error.attributes = params[:error]
    @error.save
    respond_with status: :ok
  end

  def destroy
    respond_with Error.destroy params[:id]
    respond_with status: :ok
  end

end

