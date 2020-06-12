FactoryBot.define do
  factory :entry do
    id { SecureRandom.uuid }
    association :pack
    data do
      { name: 'Linus Torvalds',
        age: 50 }
    end
  end
end
