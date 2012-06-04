class ErrorsController < ApplicationController

  respond_to :json, :html
  @@errors

  def index
    @@errors ||= []
    if params[:page].blank?
      Crashdesk::Services::CreateFakedErrorsService.reset_id
      @@errors = []
    end
    if Crashdesk::Services::CreateFakedErrorsService.id > 40
      @@errors = []
    else
      errors = Crashdesk::Services::CreateFakedErrorsService.new.execute
      @@errors = @@errors.concat errors
    end
    respond_with errors.map(&:to_json)
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

