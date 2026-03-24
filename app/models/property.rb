class Property < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  validates :name, :property_type, :city, :address, :guests_capacity, presence: true
  validates :rooms_count, numericality: { greater_than_or_equal_to: 0 }
  validates :area, numericality: { greater_than: 0, allow_nil: true }
  validates :guests_capacity, numericality: { greater_than: 0, less_than_or_equal_to: 20 }

  scope :by_city, ->(city) { where('city ILIKE ?', "%#{city}%") if city.present? }
  scope :by_type, ->(type) { where(property_type: type) if type.present? }
end
