# frozen_string_literal: true

class Suggestion < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :parent, class_name: 'Suggestion', optional: true
  has_many :suggestions, foreign_key: :parent_id, dependent: :destroy
  enum status: { accepted: 0, rejected: 1 }
end
