FactoryGirl.define do
  factory :tmp_user do
    sequence(:email) {|n| "tmp_user.#{n}@email.com"}
  end
end
