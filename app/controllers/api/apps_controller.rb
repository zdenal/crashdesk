class Api::AppsController < ApplicationController

  respond_to :json

  def index
    @apps = current_user.apps.all
  end

  def show
    @app = current_user.apps.find(params[:id])
  end

  def create
    @app = current_user.apps.build params[:app]
    if @app.save
      render :show
    else
      respond_with @app, status: :unprocessable_entity
    end
  end

  def update
    respond_with current_user.apps.find(params[:id]).update_attributes(params[:app])
  end

  def destroy
    respond_with current_user.apps.find(params[:id]).destroy
  end

end
