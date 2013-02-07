# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do
  factory :news_item do
    content Faker::Lorem.paragraph
  end
end