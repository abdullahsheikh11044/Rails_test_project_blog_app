class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :content, :image
  def image
    object.image.service_url if object.image.attached?
  end
end
