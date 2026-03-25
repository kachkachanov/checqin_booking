class Supervisor::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_supervisor!

  layout 'supervisor'

  def index
    @hotels = current_user.hotels
    @properties = current_user.properties
    @objects = (@hotels + @properties).sort_by(&:created_at)
  end

  def choice
  end

  def new_hotel
    @hotel = Hotel.new
  end

  def create_hotel
    @hotel = current_user.hotels.build(hotel_params)

    if @hotel.save
      redirect_to supervisor_success_path(type: 'hotel', id: @hotel.id), notice: 'Отель создан и отправлен на проверку'
    else
      render :new_hotel, status: :unprocessable_entity
    end
  end

  def edit_hotel
    @hotel = current_user.hotels.find(params[:id])
    render :new_hotel
  end

  def update_hotel
    @hotel = current_user.hotels.find(params[:id])

    if @hotel.update(hotel_params)
      redirect_to supervisor_root_path, notice: 'Отель обновлён.'
    else
      render :new_hotel, status: :unprocessable_entity
    end
  end

  def new_property
    @property = Property.new
  end

  def create_property
    @property = current_user.properties.build(property_params)

    if @property.save
      redirect_to supervisor_success_path(type: 'property', id: @property.id), notice: 'Жильё создано и отправлено на проверку'
    else
      render :new_property, status: :unprocessable_entity
    end
  end

  def edit_property
    @property = current_user.properties.find(params[:id])
    render :new_property
  end

  def update_property
    @property = current_user.properties.find(params[:id])

    if @property.update(property_params)
      redirect_to supervisor_root_path, notice: 'Жильё обновлено.'
    else
      render :new_property, status: :unprocessable_entity
    end
  end

  def success
    @type = params[:type]
    @object = if @type == 'hotel'
                current_user.hotels.find(params[:id])
              else
                current_user.properties.find(params[:id])
              end
  end

  private

  def require_supervisor!
    unless current_user.supervisor?
      redirect_to root_path, alert: 'Доступ запрещён. Только для супервайзоров.'
    end
  end

  def hotel_params
    params.require(:hotel).permit(:name, :hotel_type, :city, :address, :description, :chain, :base_price_per_night, :available_from, :available_to, photos: [])
  end

  def property_params
    params.require(:property).permit(:name, :property_type, :city, :address, :rooms_count, :area, :guests_capacity, :description, :base_price_per_night, :available_from, :available_to, photos: [])
  end
end
