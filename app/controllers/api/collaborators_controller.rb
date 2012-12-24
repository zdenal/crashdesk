class Api::CollaboratorsController < ApplicationController
  respond_to :json
  before_filter :get_app

  def index
    @collaborators = @app.users + @app.tmp_users
  end

  def create
    @collaborator = Crashdesk::Services::AddCollaboratorToApp.new(
      app: @app,
      params: params[:collaborator],
      current_user: current_user
    ).run
    if @collaborator.persisted?
      render 'show'
    else
      respond_with @collaborator, status: :unprocessable_entity
    end
  end

  private

  def get_app
    @app = current_user.apps.find(params[:app_id])
  end

end
