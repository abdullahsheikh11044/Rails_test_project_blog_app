# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.string :body, null: false
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.timestamps
    end

    add_index :reports, %i[user_id post_id], unique: true
  end
end
