class EntrySerializer
  include JSONAPI::Serializer
  belongs_to :pack
  attributes :data, :created_at, :updated_at
end
