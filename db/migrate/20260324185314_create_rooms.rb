class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :room_type
      t.integer :capacity
      t.decimal :area
      t.decimal :price_per_night
      t.text :description
      t.boolean :available
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
