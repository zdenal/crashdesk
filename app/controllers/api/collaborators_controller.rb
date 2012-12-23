class Api::CollaboratorsController < ApplicationController
  respond_to :json
  before_filter :get_app

  def index
    respond_with @app.users
  end

  def create
    collaborator = User.where(email: params[:collaborator][:email]).first
    collaborator ||= TmpUser.find_or_initialize_by(params[:collaborator])
    if collaborator.valid? && @app.add_collaborator(collaborator)
      collaborator.save
      render json: collaborator, status: :ok
    else
      respond_with collaborator, status: :unprocessable_entity
    end
  end

  private

  def get_app
    @app = current_user.apps.find(params[:app_id])
  end

end
