class RegistrationsController < Devise::RegistrationsController
  layout 'home'

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      Crashdesk::Services::ImportAppsFromTmpUser.new(@user).run
      redirect_to apps_url
    else
      render 'edit'
    end
  end
end
