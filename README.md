# Checqin Booking

MVP сервиса бронирования на `Ruby on Rails` с `PostgreSQL` и аутентификацией через `Devise`.

Сейчас в проекте есть 3 роли:
- `user`
- `supervisor`
- `admin`

## Стек

- `Ruby 3.3.5`
- `Rails 7.1`
- `PostgreSQL`
- `Devise`
- `Active Storage`

## Запуск проекта

### 1. Установить зависимости

```bash
bundle install
```

### 2. Настроить `PostgreSQL`

Проверь файл `config/database.yml`.

Для локальной разработки в этом проекте используется база:

```yaml
development:
  <<: *default
  database: checqin_development
```

### 3. Создать базу и применить миграции

```bash
bin/rails db:create
DISABLE_SPRING=1 bin/rails db:migrate
```

### 4. Создать admin через seeds

```bash
DISABLE_SPRING=1 bin/rails db:seed
```

### 5. Запустить сервер

```bash
bin/rails server
```

После запуска приложение будет доступно на:

`http://localhost:3000`

## Как войти в admin

Admin создаётся через `db/seeds.rb`.

Логин по умолчанию:

- `email`: `admin@roomly.local`
- `password`: `password123`

Вход:

1. открыть `http://localhost:3000/users/sign_in`
2. ввести admin-данные
3. после входа произойдёт редирект в `/admin`

Если нужно задать свои данные admin, можно перед запуском сидов передать переменные окружения:

```bash
ADMIN_EMAIL=admin@example.com ADMIN_PASSWORD=secret123 DISABLE_SPRING=1 bin/rails db:seed
```

## Как создать supervisor

Supervisor регистрируется через интерфейс.

Сценарий:

1. открыть `http://localhost:3000/users/sign_up?account_type=supervisor`
2. зарегистрироваться
3. после входа откроется кабинет супервайзора `/supervisor`

## Что уже есть в MVP

- регистрация и вход через `Devise`
- роли `user / supervisor / admin`
- кабинет супервайзора
- создание отеля и жилья
- редактирование объектов супервайзором
- цена за ночь и даты доступности у объектов
- модерация объектов через admin
- публикация только одобренных объектов

## Быстрый сценарий проверки

### Проверка supervisor flow

1. зарегистрировать `supervisor`
2. зайти в `/supervisor`
3. создать отель или жильё
4. указать цену и даты доступности
5. при необходимости отредактировать объект из кабинета

### Проверка admin flow

1. войти как `admin`
2. открыть `/admin`
3. одобрить или отклонить заявку

### Проверка публичной части

1. после одобрения объекта открыть главную `/`
2. проверить поиск `/search`
3. убедиться, что пользователю показываются только `active`-объекты

## Полезные команды

Проверка автозагрузки Rails:

```bash
DISABLE_SPRING=1 bin/rails zeitwerk:check
```

Если сервер завис из-за старого PID:

```bash
rm -f tmp/pids/server.pid
bin/rails server
```

## Примечание

В корне проекта может лежать вложенная папка `checqin_booking/`, которая не относится к основному приложению и не используется в текущем MVP.
