# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |n| "email#{n}@ruby5k.com" }
  factory :user do
    email { FactoryGirl.generate :email }
    password "password"
    password_confirmation { |x| x.password }
    trait :runkeeper do
      runkeeper_token "THE_TOKEN"
    end
    factory :runkeeper_user, traits: [:runkeeper]
  end
end
