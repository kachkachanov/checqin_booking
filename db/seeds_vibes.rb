# Seed file for vibes
Vibe.find_or_create_by(name: 'PARTY') do |vibe|
  vibe.icon = '🎉'
  vibe.description = 'Бурная ночная жизнь, бары и вечеринки'
end

Vibe.find_or_create_by(name: 'INSTAGRAM') do |vibe|
  vibe.icon = '📸'
  vibe.description = 'Красивые виды и фотогеничные места'
end

Vibe.find_or_create_by(name: 'WORKATION') do |vibe|
  vibe.icon = '💻'
  vibe.description = 'Удобно работать удалённо и отдыхать'
end

Vibe.find_or_create_by(name: 'BUDGET') do |vibe|
  vibe.icon = '💰'
  vibe.description = 'Хороший отдых без переплат'
end

Vibe.find_or_create_by(name: 'RELAX') do |vibe|
  vibe.icon = '🧘'
  vibe.description = 'Спокойный отдых, СПА и тишина'
end

# Update existing vibes with descriptions
Vibe.where(description: nil).find_each do |vibe|
  vibe.update(description: Vibe::DESCRIPTIONS[vibe.name])
end

puts "Vibes seeded successfully!"
