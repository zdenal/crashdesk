class ErrorsController < ApplicationController

  respond_to :json, :html

  def index
    #respond_with Error.all
    #errors = Crashdesk::Services::CreateFakedErrorsService.new.execute
    respond_with Crashdesk::Services::CreateFakedErrorsService.new.execute
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

