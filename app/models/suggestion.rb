# frozen_string_literal: true

class Suggestion < ApplicationRecord
  has_many :suggestions, foreign_key: :parent_id, dependent: :destroy

  belongs_to :post
  belongs_to :user
  belongs_to :parent, class_name: 'Suggestion', optional: true

  enum status: { accepted: 0, rejected: 1 }
end
