FactoryBot.define do
  factory :token do
    key { SecureRandom.urlsafe_base64(24) }
    expires_at { 2.hours.since }
    active { true }
  end
end
