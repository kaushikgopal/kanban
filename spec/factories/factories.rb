# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do

  factory :user do
    sequence(:username){ |n| "user_#{n}" }
    sequence(:email) {|n| "email#{n}@factory.com" }
    # username        Faker::Internet.user_name
    # email           Faker::Internet.safe_email
    factory :user_without_email do
      email nil
    end
    factory :full_user do
      preferred_name  Faker::Name.name
      twiki_name      Faker::Internet.user_name
    end
  end
  factory :news_item do
    association :user
    content Faker::Lorem.paragraph
  end

end
