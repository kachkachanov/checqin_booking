class AddStatusToHotelsAndProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :hotels, :status, :string, null: false, default: 'review'
    add_column :properties, :status, :string, null: false, default: 'review'

    add_index :hotels, :status
    add_index :properties, :status
  end
end
