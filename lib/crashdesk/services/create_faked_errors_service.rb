module Crashdesk::Services
  class CreateFakedErrorsService

    def initialize
      @errors = []
      10.times do
        tags = []; persons = []; customers = []
        rand(1..4).times do
          tags << Faker::Lorem.words(1)
        end
        rand(1..2).times do
          persons << Faker::Name.first_name
        end
        rand(2..3).times do
          customers << generate_customer
        end
        @errors << FakedError.new({
          title: Faker::Lorem.sentence,
          no: rand(100),
          tags: tags,
          persons: persons,
          backtrace: Faker::Lorem.paragraphs(6).join,
          customers: customers
        })
      end
    end

    def execute
      @errors.as_json.map do |error|
        error['table']
      end
    end
    
    private

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

  class FakedError < OpenStruct
  end

end
