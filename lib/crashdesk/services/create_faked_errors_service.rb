require 'net/http'

module Crashdesk
  module Services
    class CreateFakedErrorsService
      @@id = 0

      def initialize
        @errors = []
      end

      def generate_errors(app_id)
        @errors = []
        15.times do
          tags = []; person = []; customers = []
          rand(1..4).times do
            tags << Faker::Lorem.words(1)
          end
          rand(1..2).times do
            person << Faker::Name.first_name
          end
          rand(2..3).times do
            customers << generate_customer
          end
          @@id += 1
          no = rand(20)
          @errors << Error.new({
            app_id: app_id,
            title: Faker::Lorem.sentence,
            crc: Faker::Lorem.sentence,
            hash: rand(100),
            no: no,
            tags: tags,
            persons: person,
            deadline: (Date.today + rand(30)),
            error_info: generate_errors_info(no)
          })
        end
        @errors
      end

      def execute
        generate_errors
      end

      def fill_db
        App.each do |app|
          generate_errors(app.id).each{|e| e.save}
        end
      end

      def self.reset_id
        @@id = 0
      end

      def self.id
        @@id
      end

      private

      def generate_errors_info(no)
        #backtrace: Faker::Lorem.paragraphs(6).join,
        info = []
        no.times do
          info << ErrorInfo.new({
            info: {
            },
            env: {
            },
            context: {
            },
            extra: {
              customer: generate_customer
            }
          })
        end
        info
      end

      def generate_customer
        {
          name: Faker::Name.name,
          age: rand(18..60),
          no_of_cases: rand(1..15),
          comments: rand(1..3),
          gender: ['male', 'female'].sample,
          is_online: [true, false].sample
        }
      end
    end

  end
end
