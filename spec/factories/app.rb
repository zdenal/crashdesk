FactoryGirl.define do
  factory :app do
    sequence(:name) {|n| "App ##{n}"}
  end
end
