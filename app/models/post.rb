class Post < ApplicationRecord
    # has_rich_text :content
    validates :title, presence: true, length: { maximum: 15 }
    validates :content, presence: true
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :likes, as: :likeable, dependent: :destroy
end
