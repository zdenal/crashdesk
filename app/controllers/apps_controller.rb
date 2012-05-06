class AppsController < ApplicationController

  respond_to :json

  def index
    respond_with App.all
  end

  def show
    respond_with App.find params[:id]
  end

  def create
    respond_with App.create params[:app]
  end

  def update
    respond_with App.update params[:id], params[:app]
  end

  def destroy
    respond_with App.destroy params[:id]
  end

end
