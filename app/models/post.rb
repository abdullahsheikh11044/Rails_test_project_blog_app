# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 15 }
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  enum status: { publish: 0, unpublish: 1 }
  has_many :suggestions, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_rich_text :body
  validates :body, presence: true
  # validates :image, content_type: ["image/png", "image/jpeg"]
end
