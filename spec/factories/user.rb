FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user.#{n}@email.com"}
  end
end
