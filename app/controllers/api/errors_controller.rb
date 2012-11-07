class Api::ErrorsController < ApplicationController

  respond_to :json, :html
  before_filter :get_app

  def index
    @errors = @app.error_info
  end

  def show
    @error = @app.error_info.find(params[:id])
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

  private

  def get_app
    @app = App.find_by(id: params[:app_id])
  end

end

