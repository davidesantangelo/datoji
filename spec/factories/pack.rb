FactoryBot.define do
  factory :pack do
    association :token
    id { SecureRandom.uuid }
    entries_count { 0 }
  end
end
