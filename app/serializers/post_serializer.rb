class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :image, :content
end
