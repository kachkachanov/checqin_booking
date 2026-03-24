class CreateHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.text :description
      t.string :hotel_type
      t.string :city
      t.string :address
      t.string :phone
      t.string :email
      t.decimal :rating

      t.timestamps
    end
  end
end
