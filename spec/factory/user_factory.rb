# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { User.roles.keys.sample }

    trait :moderator do
      role { :moderator }
    end
    trait :user do
      role { :user }
    end
    trait :admin do
      role { :admin }
    end
    after :create, &:confirm
  end
end
