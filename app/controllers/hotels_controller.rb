class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @listings = AccommodationSearch.new(browse_all: true).call.first(3)
    @popular_cities = AccommodationSearch.popular_cities
    @vibes = Vibe.all
  end

  def search
    @city = params[:city].presence

    # нормализуем поля, чтобы browse_all корректно определялся
    @checkin = params[:checkin].presence
    @checkout = params[:checkout].presence
    @guests = params[:guests].presence

    @checkin = parse_date(@checkin)
    @checkout = parse_date(@checkout)
    @guests = @guests.to_i if @guests.present?

    browse_all = @checkin.blank? && @checkout.blank? && @guests.blank?

    search = AccommodationSearch.new(
      city: @city,
      checkin: @checkin,
      checkout: @checkout,
      guests: @guests,
      browse_all: browse_all
    )
    @listings = search.call
    @filter_types = search.filter_types

    render :search
  end

  def show
    @rooms = @hotel.rooms.available.order(:price_per_night)
    @guests = params[:guests].to_i
    @guests = 2 if @guests < 1

    min_in = @hotel.min_check_in_date
    max_out = @hotel.max_check_out_date

    @check_in = parse_date(params[:checkin]) || min_in
    @check_out = parse_date(params[:checkout]) || (@check_in + 1.day)
    @check_in = min_in if @check_in < min_in
    @check_out = @check_in + 1.day if @check_out <= @check_in
    @check_out = max_out if max_out && @check_out > max_out
    @check_in = [@check_out - 1.day, min_in].max if @check_out <= @check_in

    @bookable_rooms = @hotel.bookable_rooms_for(@check_in, @check_out, guests: @guests)
    @booking = Booking.new(check_in: @check_in, check_out: @check_out, guests: @guests)
    @selected_room = @rooms.find_by(id: params[:room_id])
  end

  def new
    @hotel = Hotel.new
  end

  def edit
  end

  def create
    @hotel = current_user.hotels.build(hotel_params)

    if @hotel.save
      redirect_to @hotel, notice: 'Отель успешно создан.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @hotel.update(hotel_params)
      redirect_to @hotel, notice: 'Отель успешно обновлен.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @hotel.destroy
    redirect_to hotels_url, notice: 'Отель успешно удален.'
  end

  private

  def set_hotel
    @hotel = Hotel.active.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name, :description, :hotel_type, :city, :address, :phone, :email, :rating, :chain, photos: [])
  end

  def parse_date(value)
    return if value.blank?

    Date.parse(value)
  rescue ArgumentError
    nil
  end
end
