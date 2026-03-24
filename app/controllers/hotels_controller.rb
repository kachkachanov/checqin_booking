class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @hotels = Hotel.all.order(created_at: :desc)
    @popular_cities = Hotel.distinct.pluck(:city).first(5)
    @popular_cities = ['Москва', 'Санкт-Петербург', 'Сочи', 'Казань', 'Калининград'] if @popular_cities.empty?
  end

  def search
    @city = params[:city]
    @checkin = params[:checkin]
    @checkout = params[:checkout]
    @guests = params[:guests].to_i

    @hotels = Hotel.all
    @hotels = @hotels.by_city(@city) if @city.present?
    @hotels = @hotels.with_available_rooms if @guests.present?

    render :search
  end

  def show
    @rooms = @hotel.rooms.available.order(:price_per_night)
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
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name, :description, :hotel_type, :city, :address, :phone, :email, :rating, :chain, photos: [])
  end
end
