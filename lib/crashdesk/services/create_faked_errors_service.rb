require 'net/http'

module Crashdesk::Services
  class CreateFakedErrorsService
    @@id = 0

    def initialize
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
        @errors << FakedError.new({
          id: @@id,
          title: Faker::Lorem.sentence,
          no: rand(100),
          tags: tags,
          person: person,
          backtrace: Faker::Lorem.paragraphs(6).join,
          customers: customers,
          deadline: (Date.today + rand(30).days)
        })
      end
    end

    def execute
      #@errors.as_json.map do |error|
        #error['table']
      #end
      @errors
    end

    def self.reset_id
      @@id = 0
    end

    def self.id
      @@id
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
    def to_json
      self.as_json['table']
    end
    def save
      req = Net::HTTP::Put.new("/errors/#{self.id}.json")
      req.body = to_json.to_s
      Net::HTTP::start('127.0.0.1', 7474).request(req)
    end
  end

end
