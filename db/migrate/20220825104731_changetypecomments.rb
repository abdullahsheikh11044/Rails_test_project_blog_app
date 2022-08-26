# frozen_string_literal: true

class Changetypecomments < ActiveRecord::Migration[5.2]
  def up
    change_column :comments, :comment, :text, null: false
  end
end
