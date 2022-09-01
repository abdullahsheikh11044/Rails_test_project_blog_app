# frozen_string_literal: true

class ChangeColumnInActionText < ActiveRecord::Migration[5.2]
  def change
    rename_column :action_text_rich_texts, :body, :content
  end
end
