class AddDescriptionToVibes < ActiveRecord::Migration[7.1]
  def change
    add_column :vibes, :description, :text
  end
end
