module Crashdesk
  module Services

    class AddCollaboratorToApp

      attr_reader :collaborator, :app, :current_user

      def initialize(params)
        @app, params, @current_user = params[:app], params[:params], params[:current_user]
        @collaborator = User.where(email: params[:email]).first
        @collaborator ||= TmpUser.find_or_initialize_by(params)
      end

      def run
        if collaborator.valid? && app.add_collaborator(collaborator)
          collaborator.save
          CollaboratorMailer.added_to_app(current_user, collaborator, app).deliver
        end
        collaborator
      end

    end

  end
end
