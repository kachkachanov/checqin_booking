class Hotel < ApplicationRecord
  belongs_to :user, optional: true
  has_many :rooms, dependent: :destroy
  has_many_attached :photos

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :hotel_type, presence: true, inclusion: {
    in: ['Отель', 'База отдыха', 'Апарт-отель', 'Гостевой дом', 'Хостел', 'Санаторий', 'Глэмпинг', 'Другое']
  }
  validates :city, :address, presence: true

  scope :by_city, ->(city) { where('city ILIKE ?', "%#{city}%") if city.present? }
  scope :by_type, ->(type) { where(hotel_type: type) if type.present? }
  scope :with_available_rooms, -> { joins(:rooms).where(rooms: { available: true }).distinct }

  def full_address
    "#{city}, #{address}"
  end

  def average_rating
    rating || 4.5
  end
end
