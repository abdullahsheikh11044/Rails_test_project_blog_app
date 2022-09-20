# frozen_string_literal: true
require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
FactoryBot.define do
  factory :user do
    name { 'Abdullah' }
    email { Faker::Internet.email }
    password { '123456' }
    role { 0 }
    after :create, &:confirm
  end
  factory :post do
    association :user
    title { 'First Post' }
    body { 'hsagjdga' }
    status { 0 }
  end
  factory :comment do
    association :user
    association :post
    comment { 'hsagjdga' }
  end
end
