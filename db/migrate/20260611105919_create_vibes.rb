class CreateVibes < ActiveRecord::Migration[7.1]
  def change
    create_table :vibes do |t|
      t.string :name, null: false
      t.string :icon, null: false

      t.timestamps
    end

    add_index :vibes, :name, unique: true
  end
end
