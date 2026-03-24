class RoomsController < ApplicationController
  before_action :set_hotel
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @rooms = @hotel.rooms.order(:price_per_night)
  end

  def show
  end

  def new
    @room = @hotel.rooms.build
  end

  def edit
  end

  def create
    @room = @hotel.rooms.build(room_params)

    if @room.save
      redirect_to [@hotel, @room], notice: 'Номер успешно добавлен.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      redirect_to [@hotel, @room], notice: 'Номер успешно обновлен.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    redirect_to hotel_rooms_url(@hotel), notice: 'Номер успешно удален.'
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end

  def set_room
    @room = @hotel.rooms.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :room_type, :capacity, :area, :price_per_night, :description, :available, photos: [])
  end
end
