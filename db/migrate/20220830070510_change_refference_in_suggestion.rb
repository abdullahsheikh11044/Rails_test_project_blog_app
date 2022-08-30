class ChangeRefferenceInSuggestion < ActiveRecord::Migration[5.2]
  def change
    change_column :suggestions, :user_id, :bigint, null: false
    change_column :suggestions, :post_id, :bigint, null: false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
