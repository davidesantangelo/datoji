class TokenSerializer
  include JSONAPI::Serializer
  attributes :key, :created_at
end
