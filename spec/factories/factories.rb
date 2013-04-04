# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do


  factory :user do |user|
    sequence(:username) { |n| "user_#{n}" }
    sequence(:email) { |n| "#{n}@factory.com" }
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
    content Faker::Lorem.paragraph
    user
  end

  factory :news_item_with_tag, :class => NewsItem do
    content Faker::Lorem.paragraph
    user
    after(:build) do |nit|
      nit.tags << FactoryGirl.create(:tag)
    end
  end

  factory :tag do
    sequence(:tag_name) { |n| "Tag #{n}"}
    # sequence(:slug){ |n| "tag_#{n}"}
  end


end
