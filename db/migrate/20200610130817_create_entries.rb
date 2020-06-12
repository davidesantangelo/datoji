class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries, id: :uuid do |t|
      t.references :pack, index: true, foreign_key: true, type: :uuid
      t.jsonb :data
      t.timestamps
    end

    add_index :entries, :data, using: :gin
  end
end
