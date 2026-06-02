admin_email = ENV.fetch('ADMIN_EMAIL', 'admin@roomly.local')
admin_password = ENV.fetch('ADMIN_PASSWORD', 'password123')

admin = User.find_or_initialize_by(email: admin_email)
admin.password = admin_password if admin.new_record?
admin.password_confirmation = admin_password if admin.new_record?
admin.role = 'admin'
admin.save!

puts "Admin ready: #{admin.email}"

if Hotel.active.none?
  demo_hotels = [
    {
      name: 'Отель Aurora',
      hotel_type: 'Отель',
      city: 'Москва',
      address: 'ул. Тверская, 12',
      description: 'Современный отель в центре Москвы с панорамным видом на город. Ресторан, спа-зона и конференц-залы.',
      rating: 4.8,
      base_price_per_night: 8500,
      available_from: Date.current,
      available_to: Date.current + 180.days,
      phone: '+7 (495) 123-45-67',
      email: 'aurora@example.com'
    },
    {
      name: 'База отдыха Сосновый бор',
      hotel_type: 'База отдыха',
      city: 'Сочи',
      address: 'пос. Лазаревское, наб. 5',
      description: 'Уютная база у моря: бассейн, детская площадка, завтрак включён.',
      rating: 4.5,
      base_price_per_night: 4200,
      available_from: Date.current,
      available_to: Date.current + 120.days,
      phone: '+7 (862) 555-12-34'
    },
    {
      name: 'Апарт-отель Нева',
      hotel_type: 'Апарт-отель',
      city: 'Санкт-Петербург',
      address: 'Невский пр., 88',
      description: 'Апартаменты с кухней в историческом центре. Идеально для длительного проживания.',
      rating: 4.6,
      base_price_per_night: 5900,
      available_from: Date.current,
      available_to: Date.current + 200.days
    }
  ]

  demo_hotels.each do |attrs|
    hotel = Hotel.create!(attrs.merge(status: 'active'))
    hotel.rooms.create!(
      name: 'Стандарт',
      room_type: 'Стандарт',
      capacity: 2,
      area: 24,
      price_per_night: hotel.base_price_per_night,
      description: 'Комфортный номер с двуспальной кроватью.',
      available: true
    )
    hotel.rooms.create!(
      name: 'Люкс',
      room_type: 'Люкс',
      capacity: 3,
      area: 38,
      price_per_night: (hotel.base_price_per_night * 1.4).round,
      description: 'Просторный номер с гостиной зоной.',
      available: true
    )
    puts "Demo hotel: #{hotel.name}"
  end
else
  puts "Active hotels already exist, skipping demo data"
end
