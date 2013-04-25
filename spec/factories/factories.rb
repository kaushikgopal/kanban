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

    factory :user_twitter_oauth do
      username "12345"
    end
  end

  factory :news_item do
    content   "a" * 140   # content Faker::Lorem.words(140)
    user
  end

  factory :tag do
    sequence(:tag_name) { |n| "Tag #{n}"}
    # sequence(:slug){ |n| "tag_#{n}"}
  end
  factory :tag_news, :parent => :tag do
    tag_name "news"
  end

  factory :news_item_with_random_tag, :parent => :news_item do
    after(:create) do |nit|
      nit.tags << FactoryGirl.create(:tag)
    end
  end

  factory :news_item_with_news_tag, :parent => :news_item do
    after(:create) do |nit|
      nit.tags << FactoryGirl.create(:tag_news)
    end
  end




end
