class Post < ApplicationRecord
    has_rich_text :content
    validates :title, presence: true
    validates :content, presence: true
    belongs_to :user
    has_many :comments
    has_many :likes
end
