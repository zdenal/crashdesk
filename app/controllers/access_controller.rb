class AccessController < ApplicationController

  def signout
    sign_out current_user
    redirect_to root_url
  end

end
