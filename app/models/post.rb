# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_rich_text :body

  belongs_to :user

  enum status: { publish: 0, unpublish: 1 }

  validates :title, presence: true, length: { maximum: 15 }
  validates :body, presence: true
end
