# TODO — Чеккин Букинг (BlackboxAI task)

## Phase 1 — Подготовка и поиск по коду
- [ ] Найти где меняется `Booking.status` на `cancelled` (отмена брони владельцем)
- [ ] Найти где обрабатывается “проблема с оплатой / отказ подтверждения”
- [ ] Найти где реализован Devise password reset (кто отправляет письмо и какие контроллеры/маилеры)

## Phase 2 — Админ: история одобрения/отказов
- [ ] Добавить модель/таблицу `ModerationEvent` (Hotel/Property, admin_id, action, from_status, to_status, message, created_at)
- [ ] Изменить `Admin::DashboardController` чтобы при approve/reject создавалась запись `ModerationEvent`
- [ ] Добавить UI в `app/views/admin/dashboard/index.html.erb`: “История” (последние события по объекту или просмотр в модалке/странице)

## Phase 3 — Супервайзер: бронирования + аналитика
- [ ] Добавить роуты `namespace :supervisor`:
  - [ ] `/supervisor/bookings`
  - [ ] `/supervisor/analytics`
- [ ] Создать контроллер/действия (или расширить `Supervisor::DashboardController`)
- [ ] Сделать простые метрики (count bookings, confirmed bookings за период, выручка по confirmed, топ-объекты)

## Phase 4 — Нотификация об экстренных ситуациях
- [ ] Добавить отправку уведомления пользователю при `Booking` переходе в `cancelled`
- [ ] Добавить уведомление при “problem with payment / отказ подтверждения” (после нахождения реального места в коде)
- [ ] Убедиться что уведомления не ломают существующие флоу (flash/ActionCable/mail)

## Phase 5 — Reset password: “забили пароль на почту”
- [ ] Проверить `app/controllers/users/passwords_controller.rb` и/или mailer/вьюхи Devise
- [ ] Убедиться, что письмо отправляется на email согласно сценарию “забыли пароль”
- [ ] При необходимости — настроить delivery и/или добавить кастомный шаблон

## Phase 6 — Наполнить базу (>= 20 жилья)
- [ ] Добавить/расширить seed для `Property` (чтобы суммарно было >= 20 “жилья”/объектов)
- [ ] Обновить `db/seeds.rb` чтобы seed запускался стабильно

## Phase 7 — Тестирование
- [ ] Critical-path: админ approve/reject + просмотр истории
- [ ] Critical-path: supervisor bookings/analytics страницы
- [ ] Critical-path: reset password по email (локально)
- [ ] Critical-path: поиск и карточки (фото-обложка стабильна)
- [ ] (опционально) Thorough: все остальные сценарии, включая отмены брони и уведомления
