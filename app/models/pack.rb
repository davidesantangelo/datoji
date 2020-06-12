class Pack < ApplicationRecord
  # relations
  has_many :entries, dependent: :destroy
  belongs_to :token
end
