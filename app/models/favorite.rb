class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  validates :user_id, uniqueness: { scope: :hotel_id }
end
