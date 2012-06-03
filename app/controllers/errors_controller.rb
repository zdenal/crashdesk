class ErrorsController < ApplicationController

  respond_to :json, :html

  def index
    #respond_with Error.all
    #errors = Crashdesk::Services::CreateFakedErrorsService.new.execute
    Crashdesk::Services::CreateFakedErrorsService.reset_id if params[:page].blank?
    if Crashdesk::Services::CreateFakedErrorsService.id > 40
      errors = []
    else
      errors = Crashdesk::Services::CreateFakedErrorsService.new.execute
    end
    respond_with errors
  end

  def show
    respond_with Error.find params[:id]
  end

  def create
    respond_with Error.create params[:app]
  end

  def update
    respond_with Error.update params[:id], params[:app]
  end

  def destroy
    #respond_with Error.destroy params[:id]
    respond_with status: :ok
  end

end

