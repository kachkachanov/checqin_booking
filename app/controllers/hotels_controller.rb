class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @hotels = Hotel.active.order(created_at: :desc)
    @popular_cities = Hotel.distinct.pluck(:city).first(5)
    @popular_cities = ['Москва', 'Санкт-Петербург', 'Сочи', 'Казань', 'Калининград'] if @popular_cities.empty?
  end

  def search
    @city = params[:city]
    @checkin = parse_date(params[:checkin])
    @checkout = parse_date(params[:checkout])
    @guests = params[:guests].to_i

    @hotels = Hotel.active
    @hotels = @hotels.by_city(@city) if @city.present?
    @hotels = @hotels.available_for_stay(@checkin, @checkout)
    @hotels = @hotels.with_available_rooms if @guests.present?

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
