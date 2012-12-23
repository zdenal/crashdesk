class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in @user
    unless @user.email?
      redirect_to edit_user_registration_url
    else
      redirect_to apps_url, notice: "Signed in"
    end
  end
  alias_method :developer, :all
  alias_method :github, :all

end
