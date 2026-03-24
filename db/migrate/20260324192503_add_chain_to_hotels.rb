class AddChainToHotels < ActiveRecord::Migration[7.1]
  def change
    add_column :hotels, :chain, :string
  end
end
