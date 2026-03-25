class Hotel < ApplicationRecord
  belongs_to :user, optional: true
  has_many :rooms, dependent: :destroy
  has_many_attached :photos

  STATUSES = %w[review active rejected].freeze

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :hotel_type, presence: true, inclusion: {
    in: ['Отель', 'База отдыха', 'Апарт-отель', 'Гостевой дом', 'Хостел', 'Санаторий', 'Глэмпинг', 'Другое']
  }
  validates :city, :address, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :base_price_per_night, presence: true, numericality: { greater_than: 0 }, if: :managed_by_supervisor?
  validates :available_from, :available_to, presence: true, if: :managed_by_supervisor?
  validate :available_to_after_available_from

  scope :active, -> { where(status: 'active') }
  scope :review, -> { where(status: 'review') }
  scope :rejected, -> { where(status: 'rejected') }
  scope :by_city, ->(city) { where('city ILIKE ?', "%#{city}%") if city.present? }
  scope :by_type, ->(type) { where(hotel_type: type) if type.present? }
  scope :with_available_rooms, -> { joins(:rooms).where(rooms: { available: true }).distinct }
  scope :available_for_stay, lambda { |checkin, checkout|
    return all if checkin.blank? || checkout.blank?

    where("available_from <= ? AND available_to >= ?", checkin, checkout)
  }

  def full_address
    "#{city}, #{address}"
  end

  def average_rating
    rating || 4.5
  end

  def display_price
    base_price_per_night.presence || rooms.minimum(:price_per_night) || 0
  end

  def availability_label
    return 'Даты по запросу' if available_from.blank? || available_to.blank?

    "#{I18n.l(available_from, format: '%d %b')} - #{I18n.l(available_to, format: '%d %b')}"
  end

  def review?
    status == 'review'
  end

  def active?
    status == 'active'
  end

  def rejected?
    status == 'rejected'
  end

  private

  def managed_by_supervisor?
    user_id.present?
  end

  def available_to_after_available_from
    return if available_from.blank? || available_to.blank?
    return if available_to >= available_from

    errors.add(:available_to, 'должна быть не раньше даты начала доступности')
  end
end
