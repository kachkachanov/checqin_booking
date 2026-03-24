class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :property_type
      t.string :city
      t.string :address
      t.integer :rooms_count
      t.decimal :area
      t.integer :guests_capacity
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
