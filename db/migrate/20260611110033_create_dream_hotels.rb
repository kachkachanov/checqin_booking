class CreateDreamHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :dream_hotels do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end

    add_index :dream_hotels, [:user_id, :hotel_id], unique: true
  end
end
