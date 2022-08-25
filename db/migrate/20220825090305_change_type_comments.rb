# frozen_string_literal: true

class ChangeTypeComments < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :comment, :text, null: true
  end
end
