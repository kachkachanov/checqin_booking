class Booking < ApplicationRecord
  STATUSES = %w[confirmed cancelled].freeze

  belongs_to :user
  belongs_to :hotel
  belongs_to :room, optional: true

  validates :check_in, :check_out, :guests, :price_per_night, :total_price, presence: true
  validates :guests, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 20 }
  validates :status, inclusion: { in: STATUSES }
  validates :price_per_night, :total_price, numericality: { greater_than: 0 }
  validate :check_out_after_check_in
  validate :check_in_not_in_past
  validate :dates_within_hotel_window
  validate :guests_fit_room_capacity
  validate :room_belongs_to_hotel
  validate :room_is_bookable
  validate :hotel_slot_available, if: -> { room_id.blank? }

  scope :confirmed, -> { where(status: 'confirmed') }
  scope :overlapping, lambda { |check_in, check_out|
    where('check_in < ? AND check_out > ?', check_out, check_in)
  }

  before_validation :assign_pricing

  def nights
    (check_out - check_in).to_i
  end

  def confirmed?
    status == 'confirmed'
  end

  def room_name
    room&.name || 'Стандартный номер'
  end

  def self.overlapping_for_room(room_id, check_in, check_out, exclude_id: nil)
    scope = confirmed.where(room_id: room_id).overlapping(check_in, check_out)
    scope = scope.where.not(id: exclude_id) if exclude_id
    scope
  end

  private

  def assign_pricing
    return if check_in.blank? || check_out.blank?
    return if check_out <= check_in

    nightly = room&.price_per_night || hotel&.base_price_per_night || hotel&.display_price
    self.price_per_night = nightly.to_d
    self.total_price = price_per_night * nights
  end

  def check_out_after_check_in
    return if check_in.blank? || check_out.blank?
    return if check_out > check_in

    errors.add(:check_out, 'должна быть позже даты заезда')
  end

  def check_in_not_in_past
    return if check_in.blank?
    return if check_in >= Date.current

    errors.add(:check_in, 'не может быть в прошлом')
  end

  def dates_within_hotel_window
    return if hotel.blank? || check_in.blank? || check_out.blank?

    if hotel.available_from.present? && check_in < hotel.available_from
      errors.add(:check_in, "не раньше #{I18n.l(hotel.available_from, format: '%d.%m.%Y')}")
    end

    if hotel.available_to.present? && check_out > hotel.available_to
      errors.add(:check_out, "не позже #{I18n.l(hotel.available_to, format: '%d.%m.%Y')}")
    end
  end

  def guests_fit_room_capacity
    return if guests.blank?

    max_capacity = room&.capacity || 2
    return if guests <= max_capacity

    errors.add(:guests, "максимум #{max_capacity} для выбранного номера")
  end

  def room_belongs_to_hotel
    return if room.blank? || hotel.blank?
    return if room.hotel_id == hotel.id

    errors.add(:room_id, 'не относится к этому отелю')
  end

  def room_is_bookable
    return if room.blank? || check_in.blank? || check_out.blank?
    return if check_out <= check_in

    unless room.available?
      errors.add(:room_id, 'недоступен для бронирования')
      return
    end

    if self.class.overlapping_for_room(room.id, check_in, check_out, exclude_id: id).exists?
      errors.add(:room_id, 'уже занят на выбранные даты')
    end
  end

  def hotel_slot_available
    return if room_id.present? || hotel.blank? || check_in.blank? || check_out.blank?
    return if check_out <= check_in

    scope = self.class.confirmed.where(hotel_id: hotel_id, room_id: nil).overlapping(check_in, check_out)
    scope = scope.where.not(id: id) if persisted?
    return unless scope.exists?

    errors.add(:base, 'На выбранные даты бронирование недоступно')
  end
end
