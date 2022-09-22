# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :post do
    association :user
    title { Faker::Lorem.word }
    body { Faker::Lorem.word }
    status { Post.statuses.keys.sample }

    trait :publish do
      status { :publish }
    end

    trait :unpublish do
      status { :unpublish }
    end
  end
end
