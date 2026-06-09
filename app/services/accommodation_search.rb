class AccommodationSearch
  Listing = Struct.new(:record, :kind, keyword_init: true) do
    delegate :id, :name, :city, :address, :created_at, :display_price, :availability_label, to: :record

    def hotel?
      kind == :hotel
    end

    def property?
      kind == :property
    end

    def type_label
      hotel? ? record.hotel_type : record.property_type
    end

    def rating
      hotel? ? (record.rating || 4.5) : 4.5
    end

    def emoji
      hotel? ? '🏨' : '🏠'
    end
  end

  def initialize(city: nil, checkin: nil, checkout: nil, guests: nil, browse_all: false)
    @city = city
    @checkin = checkin
    @checkout = checkout
    @guests = guests
    @browse_all = browse_all
  end

  def call
    hotels = filter_hotels(Hotel.active)
    properties = filter_properties(Property.active)

    listings = hotels.map { |record| Listing.new(record: record, kind: :hotel) }
    listings += properties.map { |record| Listing.new(record: record, kind: :property) }
    listings.sort_by { |listing| -listing.created_at.to_i }
  end

  def filter_types
    {
      hotels: Hotel.active.distinct.order(:hotel_type).pluck(:hotel_type).compact,
      properties: Property.active.distinct.order(:property_type).pluck(:property_type).compact
    }
  end

  def self.popular_cities(limit: 5)
    cities = (Hotel.active.distinct.pluck(:city) + Property.active.distinct.pluck(:city)).compact.uniq
    return cities.first(limit) if cities.any?

    %w[Москва Санкт-Петербург Сочи Казань Калининград].first(limit)
  end

  private

  attr_reader :city, :checkin, :checkout, :guests, :browse_all

  def filter_hotels(scope)
    scope = scope.by_city(city) if city.present?

    unless browse_all
      scope = scope.available_for_stay(checkin, checkout)
      scope = scope.with_available_rooms(guests) if guests.to_i.positive?
    end

    scope.order(created_at: :desc)
  end

  def filter_properties(scope)
    scope = scope.by_city(city) if city.present?

    unless browse_all
      scope = scope.available_for_stay(checkin, checkout)
      scope = scope.where('guests_capacity >= ?', guests) if guests.to_i.positive?
    end

    scope.order(created_at: :desc)
  end
end
