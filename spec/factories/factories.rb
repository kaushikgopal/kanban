# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do


  factory :user do
    username        Faker::Internet.user_name
    preferred_name  Faker::Name.name
    twiki_name      Faker::Internet.user_name
    email           Faker::Internet.safe_email

    factory :user_without_email do
    	email nil
    end
  end

  factory :news_item do
    association :user
    content Faker::Lorem.paragraph
  end


end
