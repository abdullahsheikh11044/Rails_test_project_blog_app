# frozen_string_literal: true

class Report < ApplicationRecord
  validates :user, uniqueness: { scope: :post_id }
  belongs_to :user
  belongs_to :post
end
