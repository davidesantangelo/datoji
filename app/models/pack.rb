class Pack < ApplicationRecord
  # relations
  has_many :entries, dependent: :destroy
  belongs_to :token

  def sync_entries_count_cache!
    Pack.reset_counters(id, :entries)
  end
end
