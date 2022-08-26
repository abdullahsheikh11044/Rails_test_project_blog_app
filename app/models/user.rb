# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # ruby after_update :send_autopilot_confirmation, if: :should_send_confirmation
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  enum roles: { user: 0, admin: 1, moderator: 2 }
  scope :user, -> { where(roles: 'user') }
  scope :admin, -> { where(roles: 'admin') }
  scope :moderator, -> { where(roles: 'moderator') }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :confirmable
end
