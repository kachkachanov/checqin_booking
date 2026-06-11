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
      description: 'Гостевой дом с садом, домашней кухней и terrase для завтраков. Спокойное место для остановки перед поездкой в горы.',
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

  # >= 20 жилых объектов
  NEW_PROPERTIES = [
    {
      slug: 'arbat-modern-apart',
      name: 'Arbat Modern Apart',
      property_type: 'Квартира',
      city: 'Москва',
      address: 'ул. Арбат, 9',
      description: 'Светлые апартаменты с рабочей зоной, полностью оборудованной кухней и быстрым Wi-Fi.',
      guests_capacity: 4,
      rooms_count: 2,
      area: 52,
      base_price_per_night: 6200,
      email: 'arbat@checqin.local'
    },
    {
      slug: 'nevsky-loft-studio',
      name: 'Nevsky Loft Studio',
      property_type: 'Апартаменты',
      city: 'Санкт-Петербург',
      address: 'ул. Невский пр., 77',
      description: 'Лофт-студия с высокими потолками, панорамными окнами и кухней-студией.',
      guests_capacity: 2,
      rooms_count: 1,
      area: 28,
      base_price_per_night: 4300,
      email: 'neva@checqin.local'
    },
    {
      slug: 'kazan-family-flat',
      name: 'Kazan Family Flat',
      property_type: 'Семейный дом',
      city: 'Казань',
      address: 'ул. Баумана, 3',
      description: 'Уютный семейный объект: две комнаты, большая гостиная и зона для отдыха.',
      guests_capacity: 5,
      rooms_count: 3,
      area: 74,
      base_price_per_night: 5900,
      email: 'kazan-f@checqin.local'
    },
    {
      slug: 'kazkrem-canal-view',
      name: 'Canal View at Kremlin',
      property_type: 'Апартаменты',
      city: 'Казань',
      address: 'ул. Кремлёвская, 18',
      description: 'Вид на историческую часть города, тихий двор и удобное расположение.',
      guests_capacity: 3,
      rooms_count: 2,
      area: 46,
      base_price_per_night: 5200,
      email: 'kremlin-view@checqin.local'
    },
    {
      slug: 'sochi-sea-breeze',
      name: 'Sochi Sea Breeze',
      property_type: 'Дом у моря',
      city: 'Сочи',
      address: 'ул. Приморская, 21',
      description: 'Дом с террасой и видом на море, идеален для семейного отдыха.',
      guests_capacity: 6,
      rooms_count: 3,
      area: 98,
      base_price_per_night: 8200,
      email: 'sea-breeze@checqin.local'
    },
    {
      slug: 'ekb-business-suites',
      name: 'EKB Business Suites',
      property_type: 'Апартаменты',
      city: 'Екатеринбург',
      address: 'ул. Малышева, 56',
      description: 'Комфортные апартаменты для командировок: быстрый интернет и тишина.',
      guests_capacity: 3,
      rooms_count: 2,
      area: 44,
      base_price_per_night: 4800,
      email: 'ekb-suites@checqin.local'
    },
    {
      slug: 'vladimir-heritage-house',
      name: 'Vladimir Heritage House',
      property_type: 'Дом',
      city: 'Владимир',
      address: 'ул. Большая Московская, 15',
      description: 'Исторический стиль, просторные комнаты и домашняя атмосфера.',
      guests_capacity: 4,
      rooms_count: 2,
      area: 61,
      base_price_per_night: 4100,
      email: 'vlad-house@checqin.local'
    },
    {
      slug: 'kaliningrad-baltic-flat',
      name: 'Baltic Flat Kaliningrad',
      property_type: 'Апартаменты',
      city: 'Калининград',
      address: 'пр. Мира, 15',
      description: 'В нескольких минутах от набережной, с балконом и видом на город.',
      guests_capacity: 3,
      rooms_count: 2,
      area: 39,
      base_price_per_night: 3700,
      email: 'kaliningrad-b@checqin.local'
    },
    {
      slug: 'nsk-green-courtyard',
      name: 'Green Courtyard Residence',
      property_type: 'Коттедж',
      city: 'Новосибирск',
      address: 'Красный пр., 41',
      description: 'Дом с двориком: место для барбекю, зона отдыха и большая кухня.',
      guests_capacity: 6,
      rooms_count: 3,
      area: 112,
      base_price_per_night: 7600,
      email: 'nsk-court@checqin.local'
    },
    {
      slug: 'murmansk-north-lodge',
      name: 'North Lodge Murmansk',
      property_type: 'Лофт-дом',
      city: 'Мурманск',
      address: 'пр. Ленина, 64',
      description: 'Теплый интерьер, панорамные окна и уютная гостиная зона.',
      guests_capacity: 4,
      rooms_count: 2,
      area: 58,
      base_price_per_night: 5100,
      email: 'north-lodge@checqin.local'
    },
    {
      slug: 'irkutsk-baikal-cabin',
      name: 'Baikal Cabin',
      property_type: 'Дом',
      city: 'Иркутск',
      address: 'ул. Карла Маркса, 8',
      description: 'Комфортный дом с камином и атмосферой путешествий к Байкалу.',
      guests_capacity: 5,
      rooms_count: 3,
      area: 86,
      base_price_per_night: 6900,
      email: 'baikal-cabin@checqin.local'
    },
    {
      slug: 'rostov-garden-suite',
      name: 'Garden Suite Rostov',
      property_type: 'Апартаменты',
      city: 'Ростов-на-Дону',
      address: 'ул. Садовая, 12',
      description: 'Апартаменты с садом и уединением, свежий ремонт и удобная транспортная доступность.',
      guests_capacity: 3,
      rooms_count: 2,
      area: 45,
      base_price_per_night: 3900,
      email: 'rostov-g@checqin.local'
    },
    {
      slug: 'krasnodar-caucasus-house',
      name: 'Caucasus House',
      property_type: 'Дом',
      city: 'Краснодар',
      address: 'ул. Красная, 140',
      description: 'Тихий дом с кухней, верандой и комнатами для больших компаний.',
      guests_capacity: 6,
      rooms_count: 3,
      area: 103,
      base_price_per_night: 7200,
      email: 'caucasus-house@checqin.local'
    },
    {
      slug: 'nn-volga-loft',
      name: 'Volga Loft NN',
      property_type: 'Апартаменты',
      city: 'Нижний Новгород',
      address: 'ул. Рождественская, 26',
      description: 'Лофт с видом на Волгу, стильный интерьер и удобная планировка.',
      guests_capacity: 4,
      rooms_count: 2,
      area: 55,
      base_price_per_night: 4600,
      email: 'volga-loft@checqin.local'
    },
    {
      slug: 'sochi-family-cottage',
      name: 'Family Cottage Sochi',
      property_type: 'Коттедж',
      city: 'Сочи',
      address: 'ул. Курортная, 5',
      description: 'Коттедж для семьи: просторные спальни, детская зона и терраса.',
      guests_capacity: 7,
      rooms_count: 4,
      area: 126,
      base_price_per_night: 9100,
      email: 'family-cottage@checqin.local'
    },
    {
      slug: 'spb-heritage-apartment',
      name: 'Heritage Apartment SPB',
      property_type: 'Апартаменты',
      city: 'Санкт-Петербург',
      address: 'наб. реки Мойки, 9',
      description: 'Объект в историческом стиле рядом с достопримечательностями.',
      guests_capacity: 3,
      rooms_count: 2,
      area: 41,
      base_price_per_night: 5200,
      email: 'moika-ap@checqin.local'
    },
    {
      slug: 'ekb-modern-flat',
      name: 'Modern Flat Ekb',
      property_type: 'Квартира',
      city: 'Екатеринбург',
      address: 'ул. Челюскинцев, 18',
      description: 'Современная квартира с удобным рабочим местом и гардеробной.',
      guests_capacity: 2,
      rooms_count: 1,
      area: 33,
      base_price_per_night: 3600,
      email: 'modern-flat@checqin.local'
    },
    {
      slug: 'vlg-volga-view',
      name: 'Volga View Apartment',
      property_type: 'Апартаменты',
      city: 'Волгоград',
      address: 'ул. Комсомольская, 22',
      description: 'Вид на набережную, уютная спальня и гостиная зона.',
      guests_capacity: 4,
      rooms_count: 2,
      area: 57,
      base_price_per_night: 3000,
      email: 'volga-view@checqin.local'
    },
    {
      slug: 'ufa-city-center-stay',
      name: 'City Center Stay Ufa',
      property_type: 'Квартира',
      city: 'Уфа',
      address: 'ул. Ленина, 101',
      description: 'Удобно для путешествий: рядом транспорт и инфраструктура.',
      guests_capacity: 3,
      rooms_count: 2,
      area: 40,
      base_price_per_night: 3200,
      email: 'ufa-center@checqin.local'
    },
    {
      slug: 'perm-forest-escape',
      name: 'Forest Escape Perm',
      property_type: 'Дом',
      city: 'Пермь',
      address: 'ул. Лесная, 7',
      description: 'Дом в окружении леса с террасой и атмосферой спокойствия.',
      guests_capacity: 5,
      rooms_count: 3,
      area: 92,
      base_price_per_night: 4400,
      email: 'perm-forest@checqin.local'
    }
  ].freeze

  def seed!
    NEW_HOTELS.each { |attrs| upsert_hotel!(attrs) }
    Hotel.active.find_each { |hotel| enrich_hotel!(hotel) }

    errors = []

    NEW_PROPERTIES.each do |attrs|
      begin
        upsert_property!(attrs, skip_photos: true)
      rescue StandardError => e
        errors << "#{attrs[:slug]}: #{e.class} #{e.message}"
      end
    end

    # гарантируем минимум 20 Property (без фото, чтобы не зависеть от внешнего URI)
    target = 20
    remaining = target - Property.count
    if remaining.positive?
      remaining.times do |i|
        begin
          slug = "auto-property-#{i + 1}-#{Time.current.to_i}"
          upsert_property!(
            {
              slug: slug,
              name: "Auto Property #{Property.count + i + 1}",
              property_type: 'Квартира',
              city: 'Москва',
              address: "ул. Тестовая, #{10 + i}",
              description: 'Автосид для теста.',
              guests_capacity: 2,
              rooms_count: 1,
              area: 30,
              base_price_per_night: 4000,
              email: "auto-#{slug}@checqin.local"
            },
            skip_photos: true
          )
        rescue StandardError => e
          errors << "#{slug}: #{e.class} #{e.message}"
        end
      end
    end

    puts "Catalog ready: #{Hotel.active.count} active hotels, #{Room.count} rooms"
    puts "Catalog ready: #{Property.count} properties"
    puts "Catalog property errors: #{errors.size}" if errors.any?

    assign_vibes_to_hotels!
  end

  VIBE_RULES = {
    'Grand Checqin Москва'      => %w[INSTAGRAM RELAX],
    'Петровский двор'            => %w[RELAX INSTAGRAM],
    'Volga Residence'            => %w[WORKATION BUDGET],
    'Baltic View'                => %w[INSTAGRAM RELAX],
    'Ural Plaza'                 => %w[WORKATION],
    'Siberia Lux'                => %w[RELAX],
    'Golden Ring Inn'            => %w[INSTAGRAM BUDGET],
    'Таврида Sun'                => %w[RELAX PARTY],
    'Neva Loft'                  => %w[INSTAGRAM],
    'Kazan Kremlin Hotel'        => %w[WORKATION INSTAGRAM],
    'Forest Glamping'            => %w[RELAX INSTAGRAM],
    'Vita Sanatorium'            => %w[RELAX],
    'Travel Hostel'              => %w[BUDGET WORKATION],
    'Lake Baikal Lodge'          => %w[RELAX INSTAGRAM],
    'Aurora Business'            => %w[WORKATION],
    'Hermitage Suites'           => %w[INSTAGRAM RELAX],
    'Caucasus Retreat'           => %w[RELAX BUDGET],
    'Volga Hostel'               => %w[BUDGET INSTAGRAM],
    'Polar Star'                 => %w[INSTAGRAM],
    'Riviera Palm'               => %w[RELAX PARTY]
  }.freeze

  def assign_vibes_to_hotels!
    HotelVibe.delete_all

    Hotel.active.find_each do |hotel|
      vibe_names = VIBE_RULES[hotel.name] || Vibe::VIBES.sample(rand(1..2))
      vibe_names.each do |name|
        vibe = Vibe.find_by(name: name)
        HotelVibe.find_or_create_by(hotel: hotel, vibe: vibe) if vibe
      end
    end
    puts "Vibes assigned to hotels: #{HotelVibe.count} associations"
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

  # -------- Properties seeding --------

  def upsert_property!(attrs, skip_photos: false)
    seed = attrs.fetch(:slug)
    data = attrs.except(:slug).merge(status: 'active', **AVAILABILITY)

    # Idempotent по (name, city)
    property = Property.find_or_initialize_by(name: data[:name], city: data[:city])
    property.assign_attributes(data)

    # photos attach (required by model validations only if attached? -> it's conditional)
    property.save!
    attach_property_photos!(property, seed) unless skip_photos
    puts "Property: #{property.name} (#{property.city})"
    property
  end

  def attach_property_photos!(property, seed, count: 2)
    return if property.photos.count >= count

    (property.photos.count...count).each do |index|
      attach_photo_from_url(
        property,
        "https://picsum.photos/seed/property-#{seed}-#{index}/960/640",
        filename: "property-#{seed}-#{index}.jpg",
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

# Seed trigger
HotelCatalogSeeder.seed!
