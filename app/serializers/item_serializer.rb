class ItemSerializer
  include JSONAPI::Serializer
  attributes :id, :image_url, :name, :detail, :price, :size, :ingredints_basic,  :fruits, :category_id, :restaurant_id
end