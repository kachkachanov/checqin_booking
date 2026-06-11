class CreateHotelSkips < ActiveRecord::Migration[7.1]
  def change
    create_table :hotel_skips do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end

    add_index :hotel_skips, [:user_id, :hotel_id], unique: true
  end
end
