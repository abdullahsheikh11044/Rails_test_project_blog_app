class ChangeNameTypeInUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :name, :string, null: false
    change_column :users, :role, :integer, null: false
  end
end
