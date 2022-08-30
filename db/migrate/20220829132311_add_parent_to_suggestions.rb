# frozen_string_literal: true

class AddParentToSuggestions < ActiveRecord::Migration[5.2]
  def change
    add_column :suggestions, :parent_id, :integer, null: true
  end
end
