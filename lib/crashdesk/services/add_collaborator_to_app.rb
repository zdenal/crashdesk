module Crashdesk
  module Services

    class AddCollaboratorToApp

      attr_reader :collaborator, :app, :inviter

      def initialize(params)
        @app, params, @inviter = params[:app], params[:params], params[:inviter]
        @collaborator = User.where(email: params[:email]).first
        @collaborator ||= TmpUser.find_or_initialize_by(params)
      end

      def run
        if collaborator.valid? && app.add_collaborator(collaborator)
          collaborator.save
          CollaboratorMailer.added_to_app(inviter, collaborator, app).deliver
        end
        collaborator
      end

    end

  end
end
