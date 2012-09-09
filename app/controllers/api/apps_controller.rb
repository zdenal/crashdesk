class Api::AppsController < ApplicationController

  respond_to :json

  def index
    respond_with current_user.apps.all
  end

  def show
    respond_with current_user.apps.find(params[:id])
  end

  def create
    respond_with current_user.apps.create params[:app]
  end

  def update
    respond_with current_user.apps.find(params[:id]).update_attributes(params[:app])
  end

  def destroy
    respond_with current_user.apps.find(params[:id]).destroy
  end

end
