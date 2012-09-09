class HomeController < ApplicationController
  layout 'home'
  skip_before_filter :authenticate_user!
end
