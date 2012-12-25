module Crashdesk
  module Services
    class SignIn

      attr_reader :user, :auth

      def initialize(_auth)
        @auth = _auth
        if Rails.env.development?
          @auth.uid = auth.info.name
        end
        @user = User.find_or_initialize_by(auth.slice(:provider, :uid)) do |user|
          user.provider = auth.provider
          user.uid = auth.uid
          user.name = auth.info.name
          user.email = auth.info.email
          # for skip email validation now
          user.skip_email_validation = true
        end
      end

      def run!
        if user.new_record?
          Crashdesk::Services::ImportAppsFromTmpUser.new(user).run
          user.save!
        end
        user
      end

    end
  end
end
