# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  belongs_to :reportable, polymorphic: true

  validates :user_id, uniqueness: { scope: %i[reportable_id reportable_type] }
  validates :body, presence: true
end
