class AddEntriesCountToPacks < ActiveRecord::Migration[6.0]
  def change
    add_column :packs, :entries_count, :integer, default: 0
  end
end
