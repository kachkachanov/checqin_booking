class CurrenciesController < ApplicationController
  def update
    code = params[:currency].to_s.upcase
    unless CurrencyHelper::CURRENCIES.key?(code)
      return respond_to do |format|
        format.html { redirect_back fallback_location: root_path, alert: 'Неизвестная валюта' }
        format.json { render json: { ok: false }, status: :unprocessable_entity }
      end
    end

    session[:currency] = code
    label = CurrencyHelper::CURRENCIES[code][:label]

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: "Валюта: #{label}" }
      format.json { render json: { ok: true, code: code, label: label } }
    end
  end
end
