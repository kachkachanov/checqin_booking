class PropertiesController < ApplicationController
  before_action :set_property, only: [:show]

  def show
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end
end
