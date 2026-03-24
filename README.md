## Шаг 1: Создаём простой README.md

```bash
nano README.md
```

```markdown
# Checqin

## Установка и запуск

### 1. Клонировать репозиторий
```bash
git clone https://github.com/kachkachanov/checqin_booking.git
cd checqin_booking
```

### 2. Переключиться на ветку develop
```bash
git checkout develop
```

### 3. Установить гемы
```bash
bundle install
```

### 4. Настроить базу данных
Создать файл `config/database.yml`:
```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: 5
  username: postgres
  password: 
  host: localhost

development:
  <<: *default
  database: checqin_development
```

### 5. Создать базу и запустить миграции
```bash
rails db:create
rails db:migrate
```

### 6. Запустить сервер
```bash
rails server
```

Открыть http://localhost:3000

### Создать супервайзера (опционально)
```bash
rails console
```
```ruby
User.create!(email: 'admin@checqin.com', password: '123456', password_confirmation: '123456', role: 'supervisor')
```
