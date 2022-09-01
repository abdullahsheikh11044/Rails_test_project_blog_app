class RemoveColumnFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :content
  end
end
