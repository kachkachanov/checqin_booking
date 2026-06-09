# frozen_string_literal: true

require 'open-uri'

module HotelCatalogSeeder
  module_function

  AVAILABILITY = {
    available_from: Date.current,
    available_to: Date.current + 365.days
  }.freeze

  NEW_HOTELS = [
    {
      slug: 'grand-checqin-moscow',
      name: 'Grand Checqin Москва',
      hotel_type: 'Отель',
      city: 'Москва',
      address: 'ул. Арбат, 24',
      description: 'Премиальный городской отель в шаге от исторического центра. Панорамный ресторан на крыше, фитнес-центр и круглосуточный консьерж-сервис.',
      rating: 4.9,
      base_price_per_night: 12_500,
      phone: '+7 (495) 700-11-01',
      email: 'moscow@checqin.local'
    },
    {
      slug: 'petrovsky-dvor-spb',
      name: 'Петровский двор',
      hotel_type: 'Гостевой дом',
      city: 'Санкт-Петербург',
      address: 'наб. реки Мойки, 56',
      description: 'Уютный гостевой дом в историческом особняке XVIII века. Каминный зал, завтраки по домашним рецептам и вид на каналы.',
      rating: 4.7,
      base_price_per_night: 6800,
      phone: '+7 (812) 700-11-02'
    },
    {
      slug: 'volga-residence-kazan',
      name: 'Volga Residence',
      hotel_type: 'Апарт-отель',
      city: 'Казань',
      address: 'ул. Баумана, 19',
      description: 'Современные апартаменты с полностью оборудованной кухней рядом с Кремлём. Подходит для семей и длительных командировок.',
      rating: 4.6,
      base_price_per_night: 5400,
      email: 'kazan@checqin.local'
    },
    {
      slug: 'baltic-view-kaliningrad',
      name: 'Baltic View',
      hotel_type: 'Отель',
      city: 'Калининград',
      address: 'пр. Мира, 88',
      description: 'Отель с видом на залив и террасой для завтраков. Рядом набережная, музеи и прогулочные маршруты по старому городу.',
      rating: 4.5,
      base_price_per_night: 4900,
      phone: '+7 (401) 700-11-04'
    },
    {
      slug: 'ural-plaza-ekb',
      name: 'Ural Plaza',
      hotel_type: 'Отель',
      city: 'Екатеринбург',
      address: 'ул. Малышева, 51',
      description: 'Деловой отель в центре Екатеринбурга с конференц-залами, underground-парковкой и быстрым Wi-Fi для удалённой работы.',
      rating: 4.4,
      base_price_per_night: 6200,
      email: 'ekb@checqin.local'
    },
    {
      slug: 'siberia-lux-nsk',
      name: 'Siberia Lux',
      hotel_type: 'Отель',
      city: 'Новосибирск',
      address: 'Красный пр., 35',
      description: 'Просторные номера, спа-зона и ресторан с сибирской кухней. Удобная локация для транзитных и деловых поездок.',
      rating: 4.3,
      base_price_per_night: 5800,
      phone: '+7 (383) 700-11-06'
    },
    {
      slug: 'golden-ring-vladimir',
      name: 'Golden Ring Inn',
      hotel_type: 'Отель',
      city: 'Владимир',
      address: 'ул. Большая Московская, 12',
      description: 'Отель для путешественников по Золотому кольцу: тёплый интерьер, карта маршрутов и трансфер к главным достопримечательностям.',
      rating: 4.6,
      base_price_per_night: 4100,
      email: 'vladimir@checqin.local'
    },
    {
      slug: 'tavrida-sun-sochi',
      name: 'Таврида Sun',
      hotel_type: 'База отдыха',
      city: 'Сочи',
      address: 'Курортный пр., 72',
      description: 'База отдыха у моря с бассейном, детской анимацией и собственным пляжным клубом. Идеальна для семейного отпуска.',
      rating: 4.8,
      base_price_per_night: 7200,
      phone: '+7 (862) 700-11-08'
    },
    {
      slug: 'neva-loft-spb',
      name: 'Neva Loft',
      hotel_type: 'Апарт-отель',
      city: 'Санкт-Петербург',
      address: 'пр. Обуховской Обороны, 120',
      description: 'Лофт-апартаменты в стиле industrial chic с высокими потолками и кухней-студией. 15 минут до метро и центра.',
      rating: 4.5,
      base_price_per_night: 5600,
      email: 'loft@checqin.local'
    },
    {
      slug: 'kazan-kremlin-hotel',
      name: 'Kazan Kremlin Hotel',
      hotel_type: 'Отель',
      city: 'Казань',
      address: 'ул. Кремлёвская, 5',
      description: 'Отель бизнес-класса с видом на Казанский Кремль. Лаундж для переговоров, прачечная и room-service до полуночи.',
      rating: 4.7,
      base_price_per_night: 7800,
      phone: '+7 (843) 700-11-10'
    },
    {
      slug: 'forest-glamping-moscow',
      name: 'Forest Glamping',
      hotel_type: 'Глэмпинг',
      city: 'Москва',
      address: 'Рублёво-Успенское ш., 15',
      description: 'Эко-глэмпинг в сосновом лесу: отдельные купола с отоплением, терраса, барбекю-зона и прогулочные тропы.',
      rating: 4.9,
      base_price_per_night: 9500,
      email: 'glamp@checqin.local'
    },
    {
      slug: 'vita-sanatorium-sochi',
      name: 'Vita Sanatorium',
      hotel_type: 'Санаторий',
      city: 'Сочи',
      address: 'ул. Гагарина, 44',
      description: 'Санаторий с минeral-ваннами, ингаляторием и программами wellness. Спокойная атмосфера и диетическое меню.',
      rating: 4.6,
      base_price_per_night: 8400,
      phone: '+7 (862) 700-11-12'
    },
    {
      slug: 'travel-hostel-moscow',
      name: 'Travel Hostel',
      hotel_type: 'Хостел',
      city: 'Москва',
      address: 'ул. Маросейская, 8',
      description: 'Современный хостел для бэкпекеров: капсульные и общие номера, кухня, коворкинг и бесплатные экскурсии по району.',
      rating: 4.2,
      base_price_per_night: 1800,
      email: 'hostel@checqin.local'
    },
    {
      slug: 'baikal-lodge-irkutsk',
      name: 'Lake Baikal Lodge',
      hotel_type: 'База отдыха',
      city: 'Иркутск',
      address: 'ул. Карла Маркса, 22',
      description: 'База отдыха с организованными турами на Байкал, сауна и ресторан с оmulом. Тёплый каминный зал зимой.',
      rating: 4.8,
      base_price_per_night: 6500,
      phone: '+7 (395) 700-11-14'
    },
    {
      slug: 'aurora-business-moscow',
      name: 'Aurora Business',
      hotel_type: 'Отель',
      city: 'Москва',
      address: 'Ленинградский пр., 37',
      description: 'Отель для деловых поездок рядом с деловым центром Москва-Сити. Express check-in, переговорные и завтраки to-go.',
      rating: 4.5,
      base_price_per_night: 8900,
      email: 'business@checqin.local'
    },
    {
      slug: 'hermitage-suites-spb',
      name: 'Hermitage Suites',
      hotel_type: 'Апарт-отель',
      city: 'Санкт-Петербург',
      address: 'Дворцовая пл., 2',
      description: 'Апартаменты премиум-класса в шаге от Эрmitage. Дизайнерский ремонт, посудомоечная машина и вид на Неву.',
      rating: 4.9,
      base_price_per_night: 11_200,
      phone: '+7 (812) 700-11-16'
    },
    {
      slug: 'caucasus-retreat-krasnodar',
      name: 'Caucasus Retreat',
      hotel_type: 'Гостевой дом',
      city: 'Краснодар',
      address: 'ул. Красная, 120',
      description: 'Гостевой дом с садом, домашней кухней и терrace для завтраков. Спокойное место для остановки перед поездкой в горы.',
      rating: 4.4,
      base_price_per_night: 3200,
      email: 'caucasus@checqin.local'
    },
    {
      slug: 'volga-hostel-nn',
      name: 'Volga Hostel',
      hotel_type: 'Хостел',
      city: 'Нижний Новгород',
      address: 'ул. Рождественская, 18',
      description: 'Хостел в историческом центре Нижнего Новгорода: общая гостиная, настольные игры и вид на Волгу с крыши.',
      rating: 4.3,
      base_price_per_night: 1600,
      phone: '+7 (831) 700-11-18'
    },
    {
      slug: 'polar-star-murmansk',
      name: 'Polar Star',
      hotel_type: 'Отель',
      city: 'Мурманск',
      address: 'пр. Ленина, 82',
      description: 'Отель в Мурманске с программами северного сияния, тёплыми номерами и рестораном с морепродуктами.',
      rating: 4.5,
      base_price_per_night: 5200,
      email: 'polar@checqin.local'
    },
    {
      slug: 'riviera-palm-sochi',
      name: 'Riviera Palm',
      hotel_type: 'База отдыха',
      city: 'Сочи',
      address: 'ул. Примorskaya, 9',
      description: 'Курортная база с пальмовым садом, двумя бассейнами и анимацией для детей. Завтрак и шезлонги у бассейна включены.',
      rating: 4.7,
      base_price_per_night: 7600,
      phone: '+7 (862) 700-11-20'
    }
  ].freeze

  def seed!
    NEW_HOTELS.each { |attrs| upsert_hotel!(attrs) }
    Hotel.active.find_each { |hotel| enrich_hotel!(hotel) }
    puts "Catalog ready: #{Hotel.active.count} active hotels, #{Room.count} rooms"
  end

  def upsert_hotel!(attrs)
    slug = attrs.fetch(:slug)
    data = attrs.except(:slug).merge(status: 'active', **AVAILABILITY)
    hotel = Hotel.find_or_initialize_by(name: data[:name], city: data[:city])
    hotel.assign_attributes(data)
    hotel.save!
    ensure_rooms!(hotel)
    attach_photos!(hotel, slug)
    puts "Hotel: #{hotel.name} (#{hotel.city})"
    hotel
  end

  def enrich_hotel!(hotel)
    hotel.update!(AVAILABILITY) if hotel.available_from.blank? || hotel.available_to.blank?
    hotel.update!(base_price_per_night: hotel.rooms.minimum(:price_per_night) || 3500) if hotel.base_price_per_night.blank?
    ensure_rooms!(hotel)
    slug = hotel.name.parameterize
    attach_photos!(hotel, slug) unless hotel.photos.attached?
  end

  def ensure_rooms!(hotel)
    base = hotel.base_price_per_night || hotel.rooms.minimum(:price_per_night) || 3500

    if hotel.rooms.none?
      create_default_rooms!(hotel, base)
      return
    end

    hotel.update!(base_price_per_night: base) if hotel.base_price_per_night.blank?

    unless hotel.rooms.exists?(['capacity >= ?', 4])
      hotel.rooms.create!(
        name: 'Семейный',
        room_type: 'Семейный',
        capacity: 4,
        area: 36,
        price_per_night: (base * 1.35).round,
        description: 'Просторный номер для семьи с двумя спальными местами.',
        available: true
      )
    end
  end

  def create_default_rooms!(hotel, base)
    [
      {
        name: 'Стандарт',
        room_type: 'Стандарт',
        capacity: 2,
        area: 22,
        price_per_night: base,
        description: 'Комфортный номер с двуспальной кроватью и рабочей зоной.'
      },
      {
        name: 'Семейный',
        room_type: 'Семейный',
        capacity: 4,
        area: 36,
        price_per_night: (base * 1.35).round,
        description: 'Просторный номер для семьи с двумя спальными местами.'
      },
      {
        name: 'Люкс',
        room_type: 'Люкс',
        capacity: 3,
        area: 42,
        price_per_night: (base * 1.55).round,
        description: 'Номер люкс с гостиной зоной и улучшенным видом.'
      }
    ].each do |room_attrs|
      hotel.rooms.create!(room_attrs.merge(available: true))
    end
  end

  def attach_photos!(hotel, seed, count: 2)
    return if hotel.photos.count >= count

    (hotel.photos.count...count).each do |index|
      attach_photo_from_url(
        hotel,
        "https://picsum.photos/seed/#{seed}-#{index}/960/640",
        filename: "#{seed}-#{index}.jpg",
        content_type: 'image/jpeg'
      )
    end
  end

  def attach_photo_from_url(record, url, filename:, content_type:)
    io = URI.open(url, read_timeout: 20, open_timeout: 10, 'User-Agent' => 'ChecqinSeeder/1.0')
    record.photos.attach(io: io, filename: filename, content_type: content_type)
    puts "  + photo #{filename} -> #{record.name}"
  rescue StandardError => e
    puts "  ! photo skipped for #{record.name}: #{e.message}"
  end
end

HotelCatalogSeeder.seed!
