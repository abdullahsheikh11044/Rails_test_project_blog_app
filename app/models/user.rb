# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :timeoutable, :trackable and :omniauthable

  # ruby after_update :send_autopilot_confirmation, if: :should_send_confirmation
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :reports, dependent: :destroy
  enum role: { user: 0, admin: 1, moderator: 2 }
  validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :confirmable
end
