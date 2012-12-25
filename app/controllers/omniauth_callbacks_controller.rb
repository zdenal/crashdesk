class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    @user = Crashdesk::Services::SignIn.new(request.env["omniauth.auth"]).run!
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
