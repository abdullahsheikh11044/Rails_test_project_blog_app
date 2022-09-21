# frozen_string_literal: true
require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
FactoryBot.define do  
  factory :post do
    association :user
    title { Faker::Lorem.word}
    body { Faker::Lorem.word }
    status { 0 }
  end
end
