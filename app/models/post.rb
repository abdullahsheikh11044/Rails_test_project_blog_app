# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 15 }
  validates :content, presence: true, length: { maximum: 25 }
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  enum status: { publish: 0, unpublish: 1 }
end
