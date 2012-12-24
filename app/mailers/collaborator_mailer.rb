class CollaboratorMailer < ActionMailer::Base
  default from: "info@crashde.sk"

  def added_to_app(inviter, new_user, app)
    @inviter, @new_user, @app = inviter, new_user, app
    mail(to: @new_user.email, subject: 'You were invited to Crashde.sk error tracking project')
  end
end
