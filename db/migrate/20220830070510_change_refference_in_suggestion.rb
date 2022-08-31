# frozen_string_literal: true

class ChangeRefferenceInSuggestion < ActiveRecord::Migration[5.2]
  def change
    change_column :suggestions, :user_id, :bigint, null: false
    change_column :suggestions, :post_id, :bigint, null: false
  end
end
