# frozen_string_literal: true

class Changetypeposts < ActiveRecord::Migration[5.2]
  def up
    change_column :posts, :title, :string, null: false
    change_column :posts, :content, :text, null: false
  end
end
