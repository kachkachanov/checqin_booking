class TravelStreakController < ApplicationController
  before_action :authenticate_user!

  def show
    service = TravelStreakService.new(current_user)
    @streak_info = service.calculate_streak

    respond_to do |format|
      format.html
      format.json { render json: @streak_info, status: :ok }
    end
  end
end
