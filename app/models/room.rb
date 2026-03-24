class Room < ApplicationRecord
  belongs_to :hotel
  has_many_attached :photos

  ROOM_TYPES = ['Стандарт', 'Люкс', 'Семейный', 'Эконом', 'Студия', 'Президентский']

  validates :name, :room_type, presence: true
  validates :room_type, inclusion: { in: ROOM_TYPES }
  validates :capacity, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
  validates :area, presence: true, numericality: { greater_than: 0 }
  validates :price_per_night, presence: true, numericality: { greater_than: 0 }

  scope :available, -> { where(available: true) }
  scope :by_type, ->(type) { where(room_type: type) if type.present? }
  scope :by_capacity, ->(capacity) { where('capacity >= ?', capacity) if capacity.present? }
  scope :by_price_range, ->(min, max) { where(price_per_night: min..max) if min.present? && max.present? }

  def formatted_price
    "#{price_per_night.to_i} ₽/ночь"
  end

  def short_info
    "#{name} (#{room_type}, до #{capacity} чел.)"
  end
end
