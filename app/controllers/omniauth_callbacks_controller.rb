class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      sign_in user
      redirect_to apps_url, notice: "Signed in"
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end

  end
  alias_method :developer, :all
  alias_method :github, :all

end
