class TokenSerializer
  include FastJsonapi::ObjectSerializer
  attributes :key, :created_at
end
