class PackSerializer
  include JSONAPI::Serializer
  attributes :entries_count, :created_at, :updated_at
end
