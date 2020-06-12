class EntrySerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :pack
  attributes :data, :created_at, :updated_at
end
