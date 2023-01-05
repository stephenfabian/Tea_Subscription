class SubscriptionsSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :price
end
