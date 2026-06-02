module CurrencyHelper
  CURRENCIES = {
    'RUB' => { symbol: '₽', label: 'RUB ₽', rate: 1.0 },
    'USD' => { symbol: '$', label: 'USD $', rate: 0.011 },
    'EUR' => { symbol: '€', label: 'EUR €', rate: 0.010 }
  }.freeze

  def current_currency_code
    code = session[:currency].to_s.upcase
    CURRENCIES.key?(code) ? code : 'RUB'
  end

  def current_currency_label
    CURRENCIES[current_currency_code][:label]
  end

  def format_hotel_price(amount)
    info = CURRENCIES[current_currency_code]
    converted = (amount.to_f * info[:rate]).round
    "#{info[:symbol]}#{converted}"
  end
end
