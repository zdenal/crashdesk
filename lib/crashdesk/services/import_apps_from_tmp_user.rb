module Crashdesk
  module Services
    class ImportAppsFromTmpUser

      attr_reader :user, :tmp_user

      def initialize(user)
        @user = user
        @tmp_user = TmpUser.where(email: user.email).first if user.email?
      end

      def run
        if tmp_user
          user.apps.concat(tmp_user.apps)
          tmp_user.destroy
        end
      end

    end
  end
end
