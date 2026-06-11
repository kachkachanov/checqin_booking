class Supervisor::AnalyticsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_supervisor!

  layout 'supervisor'

  def index
    hotel_ids = current_user.hotels.select(:id)

    confirmed = Booking.confirmed.where(hotel_id: hotel_ids)

    @total_confirmed_bookings = confirmed.count
    @total_revenue = confirmed.sum(:total_price)

    from_time = 30.days.ago.beginning_of_day
    @bookings_by_day = confirmed
                          .where('created_at >= ?', from_time)
                          .group('DATE(created_at)')
                          .order('DATE(created_at) ASC')
                          .count

    @top_hotels = confirmed
                    .group(:hotel_id)
                    .order(Arel.sql('SUM(total_price) DESC'))
                    .limit(5)
                    .sum(:total_price)
  end

  private

  def require_supervisor!
    unless current_user.supervisor?
      redirect_to root_path, alert: 'Доступ запрещён. Только для супервайзоров.'
    end
  end
end
