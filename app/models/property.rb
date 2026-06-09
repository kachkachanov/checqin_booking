class Property < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  validates :photos,
            content_type: { in: %w[image/png image/jpeg image/jpg image/pjpeg image/webp],
                            message: 'должны быть в формате PNG или JPG' },
            size: { less_than: 10.megabytes },
            if: -> { photos.attached? }

  STATUSES = %w[review active rejected].freeze

  validates :name, :property_type, :city, :address, :guests_capacity, presence: true
  validates :rooms_count, numericality: { greater_than_or_equal_to: 0 }
  validates :area, numericality: { greater_than: 0, allow_nil: true }
  validates :guests_capacity, numericality: { greater_than: 0, less_than_or_equal_to: 20 }
  validates :status, inclusion: { in: STATUSES }
  validates :base_price_per_night, presence: true, numericality: { greater_than: 0 }
  validates :available_from, :available_to, presence: true
  validate :available_to_after_available_from

  scope :active, -> { where(status: 'active') }
  scope :review, -> { where(status: 'review') }
  scope :rejected, -> { where(status: 'rejected') }
  scope :by_city, ->(city) { where('city ILIKE ?', "%#{city}%") if city.present? }
  scope :by_type, ->(type) { where(property_type: type) if type.present? }
  scope :available_for_stay, lambda { |checkin, checkout|
    return all if checkin.blank? || checkout.blank?

    where(
      '(available_from IS NULL OR available_from <= ?) AND (available_to IS NULL OR available_to >= ?)',
      checkin, checkout
    )
  }

  def display_price
    base_price_per_night || 0
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

  def available_to_after_available_from
    return if available_from.blank? || available_to.blank?
    return if available_to >= available_from

    errors.add(:available_to, 'должна быть не раньше даты начала доступности')
  end
end
