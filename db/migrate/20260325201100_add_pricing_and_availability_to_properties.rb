class AddPricingAndAvailabilityToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :base_price_per_night, :decimal
    add_column :properties, :available_from, :date
    add_column :properties, :available_to, :date
  end
end
