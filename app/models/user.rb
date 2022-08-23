class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable

  #ruby after_update :send_autopilot_confirmation, if: :should_send_confirmation
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :confirmable
end
