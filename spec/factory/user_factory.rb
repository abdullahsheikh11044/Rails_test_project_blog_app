# frozen_string_literal: true
require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
FactoryBot.define do
  factory :user do
    name { Faker::Name.name  }
    email { Faker::Internet.email }
    password { '123456' }
    role { 0 }
    after :create, &:confirm
  end
end
