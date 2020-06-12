class PackSerializer
  include FastJsonapi::ObjectSerializer
  attributes :entries_count, :created_at, :updated_at
end
