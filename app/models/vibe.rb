class Vibe < ApplicationRecord
  VIBES = %w[PARTY INSTAGRAM WORKATION BUDGET RELAX].freeze

  DESCRIPTIONS = {
    'PARTY' => 'Бурная ночная жизнь, бары и вечеринки',
    'INSTAGRAM' => 'Красивые виды и фотogenic места',
    'WORKATION' => 'Удобно работать удалённо и отдыхать',
    'BUDGET' => 'Хороший отдых без переплат',
    'RELAX' => 'Спокойный отдых, СПА и тишина'
  }.freeze

  has_many :hotel_vibes, dependent: :destroy
  has_many :hotels, through: :hotel_vibes

  validates :name, presence: true, uniqueness: true, inclusion: { in: VIBES }
  validates :icon, presence: true

  def display_name
    name.humanize
  end

  def description
    DESCRIPTIONS[name]
  end

  def hotels_count
    hotels.active.count
  end
end
