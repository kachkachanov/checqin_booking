class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true
      t.references :room, null: true, foreign_key: true
      t.date :check_in, null: false
      t.date :check_out, null: false
      t.integer :guests, null: false, default: 1
      t.decimal :price_per_night, precision: 10, scale: 2, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.string :status, null: false, default: 'confirmed'

      t.timestamps
    end

    add_index :bookings, [:hotel_id, :check_in, :check_out]
    add_index :bookings, [:room_id, :check_in, :check_out]
    add_index :bookings, :status
  end
end
