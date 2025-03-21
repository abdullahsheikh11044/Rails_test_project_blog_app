# frozen_string_literal: true

class AddLockableToDevise < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :users, :locked_at, :datetime

    # Add these only if unlock strategy is :email or :both
    add_column :users, :unlock_token, :string
    add_index :users, :unlock_token, unique: true
  end
end
