# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :comment, presence: true, length: { maximum: 25 }
  
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true
  
  has_one_attached :picture, dependent: :destroy
  
  
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
end
