module Crashdesk
  module Services

    class ProcessError

      attr_reader :app, :params

      def initialize(params)
        @params = params
        @app = App.find_by(uuid: params[:api_key])
        @error = app.error.find_by(crc: params[:crc])
      end

      def run
        if @error.present?
          create_error_info
        else
          create_new_error
        end
      end

      private

      def create_new_error
        @error = @app.errors.create
          {
            crc:    @params[:crc],
            hash:   @params[:hash],
            title:  @params[:exceptional_message]
          }
          create_error_info
      end

      def create_error_info
        @error_info = @error.error_info.create
          {
            env:              @params[:environment],
            backtrace:        @params[:backtrace],
            occured_at:       @params[:occured_at],
            exception_class:  @params[:exception_class]
          }
      end

    end

  end
end
