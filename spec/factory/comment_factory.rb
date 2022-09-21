# frozen_string_literal: true
require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
FactoryBot.define do
  factory :comment do
    association :user
    association :post
    comment { Faker::Lorem.word }
  end
end
