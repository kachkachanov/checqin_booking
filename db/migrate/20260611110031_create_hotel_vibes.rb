class CreateHotelVibes < ActiveRecord::Migration[7.1]
  def change
    create_table :hotel_vibes do |t|
      t.references :hotel, null: false, foreign_key: true
      t.references :vibe, null: false, foreign_key: true

      t.timestamps
    end

    add_index :hotel_vibes, [:hotel_id, :vibe_id], unique: true
  end
end
