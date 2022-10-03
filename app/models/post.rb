# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_rich_text :body
  before_save :update_old_body

private

def update_old_body
  self.content = body&.body&.to_s unless content
rescue ActionView::Template::Error
    build_rich_text_body
end

  belongs_to :user

  enum status: { publish: 0, unpublish: 1 }

  validates :title, presence: true, length: { maximum: 15 }
  validates :body, presence: true
end
