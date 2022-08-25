# frozen_string_literal: true

class ChangeTypeInComments < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :comment, :text, null: false
  end
end
