class Entry < ApplicationRecord
  # scopes
  default_scope -> { order(created_at: :desc) }

  # relations
  belongs_to :pack, counter_cache: true

  # validations
  validates :data, presence: true
  validates :pack, presence: true
end
