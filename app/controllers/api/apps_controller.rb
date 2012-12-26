class Api::AppsController < ApplicationController

  respond_to :json

  before_filter :get_app, only: [:show, :update, :destroy]

  def index
    @apps = current_user.apps.all
  end

  def show
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
    respond_with @app.update_attributes(params[:app])
  end

  def destroy
    respond_with @app.remove_collaborators(current_user)
  end

  private

  def get_app
    @app = current_user.apps.find(params[:id])
  end

end
