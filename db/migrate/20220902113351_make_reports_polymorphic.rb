class MakeReportsPolymorphic < ActiveRecord::Migration[5.2]
  def change
    rename_column :reports, :post_id, :reportable_id
    add_column :reports, :reportable_type, :string

    remove_index :reports, [:user_id, :reportable_id]
    add_index :reports, [:user_id, :reportable_id, :reportable_type],unique: true
    add_index :reports, [:reportable_id, :reportable_type]
  end
end
