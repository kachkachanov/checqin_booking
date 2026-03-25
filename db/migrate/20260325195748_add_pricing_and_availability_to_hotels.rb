class AddPricingAndAvailabilityToHotels < ActiveRecord::Migration[7.1]
  def change
    add_column :hotels, :base_price_per_night, :decimal
    add_column :hotels, :available_from, :date
    add_column :hotels, :available_to, :date
  end
end
