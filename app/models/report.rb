# frozen_string_literal: true

class Report < ApplicationRecord
  validates :user_id, uniqueness: { scope: %i[reportable_id reportable_type] }
  validates :body, presence: true
  belongs_to :user
  belongs_to :reportable, polymorphic: true
end
