# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :comment do
    association :user
    association :post
    comment { Faker::Lorem.word }
  end
end
