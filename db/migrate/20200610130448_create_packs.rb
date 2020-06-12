class CreatePacks < ActiveRecord::Migration[6.0]
  def change
    create_table :packs, id: :uuid do |t|
      t.references :token, index: true, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
