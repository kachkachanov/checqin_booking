# Checqin Booking — все фронтенд-файлы


---

## `app/javascript/channels/consumer.js`

```
// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `bin/rails generate channel` command.

import { createConsumer } from "@rails/actioncable"

export default createConsumer()
```

---

## `app/javascript/channels/index.js`

```
// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)
```

---

## `app/views/admin/dashboard/index.html.erb`

```
<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Roomly Admin</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body class="min-h-screen bg-[#050f0c] text-[#e8f5f1]" style="font-family:'Plus Jakarta Sans',sans-serif">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-8">
      <div>
        <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-bold uppercase tracking-[1.4px] text-[#1db896] border border-[#1db896]/30 bg-[#1db896]/10 mb-3">
          Admin
        </div>
        <h1 class="text-3xl sm:text-4xl" style="font-family:'DM Serif Display',serif">Модерация объектов</h1>
        <p class="text-sm text-[#9bbdb5] mt-2">Одобряйте публикацию объектов или отклоняйте их после проверки.</p>
      </div>
      <div class="flex items-center gap-3">
        <div class="text-sm text-[#9bbdb5]">
          Вошли как <span class="text-[#e8f5f1] font-semibold"><%= current_user.email %></span>
        </div>
        <%= button_to "Выйти", destroy_user_session_path, method: :delete, class: "px-4 py-2 rounded-xl border border-white/10 bg-white/5 text-sm font-semibold text-[#9bbdb5] cursor-pointer hover:border-[#1db896] hover:text-[#1db896]", form: { data: { turbo: false } } %>
      </div>
    </div>

    <% if notice.present? %>
      <div class="mb-6 rounded-2xl border border-[#1db896]/30 bg-[#1db896]/10 px-4 py-3 text-sm text-[#e8f5f1]"><%= notice %></div>
    <% end %>

    <% if alert.present? %>
      <div class="mb-6 rounded-2xl border border-red-400/30 bg-red-400/10 px-4 py-3 text-sm text-red-200"><%= alert %></div>
    <% end %>

    <div class="grid lg:grid-cols-2 gap-6">
      <section class="rounded-3xl border border-white/10 bg-white/5 p-5">
        <div class="flex items-center justify-between mb-5">
          <h2 class="text-2xl" style="font-family:'DM Serif Display',serif">Отели</h2>
          <span class="text-sm text-[#9bbdb5]"><%= @hotels.count %> шт.</span>
        </div>

        <% if @hotels.any? %>
          <div class="space-y-4">
            <% @hotels.each do |hotel| %>
              <div class="rounded-2xl border border-white/10 bg-[#091410] p-4">
                <div class="flex items-start justify-between gap-4">
                  <div>
                    <div class="font-semibold text-lg"><%= hotel.name %></div>
                    <div class="text-sm text-[#9bbdb5] mt-1"><%= hotel.city %>, <%= hotel.address %></div>
                    <div class="text-xs text-[#5a8078] mt-2">Представитель: <%= hotel.user&.email || 'не указан' %></div>
                  </div>
                  <span class="px-3 py-1 rounded-full text-xs font-bold bg-yellow-300/15 text-yellow-300">
                    На проверке
                  </span>
                </div>

                <div class="mt-4 flex gap-3">
                  <%= button_to "Одобрить", admin_approve_hotel_path(hotel), method: :patch, class: "px-4 py-2 rounded-xl bg-[#1db896] text-[#050f0c] font-bold text-sm border-0 cursor-pointer" %>
                  <%= button_to "Отклонить", admin_reject_hotel_path(hotel), method: :patch, class: "px-4 py-2 rounded-xl bg-red-400/85 text-white font-bold text-sm border-0 cursor-pointer" %>
                </div>
              </div>
            <% end %>
          </div>
        <% else %>
          <div class="rounded-2xl border border-dashed border-white/10 bg-[#091410] p-6 text-sm text-[#9bbdb5]">
            Новых заявок по отелям на модерации нет.
          </div>
        <% end %>
      </section>

      <section class="rounded-3xl border border-white/10 bg-white/5 p-5">
        <div class="flex items-center justify-between mb-5">
          <h2 class="text-2xl" style="font-family:'DM Serif Display',serif">Жильё</h2>
          <span class="text-sm text-[#9bbdb5]"><%= @properties.count %> шт.</span>
        </div>

        <% if @properties.any? %>
          <div class="space-y-4">
            <% @properties.each do |property| %>
              <div class="rounded-2xl border border-white/10 bg-[#091410] p-4">
                <div class="flex items-start justify-between gap-4">
                  <div>
                    <div class="font-semibold text-lg"><%= property.name %></div>
                    <div class="text-sm text-[#9bbdb5] mt-1"><%= property.city %>, <%= property.address %></div>
                    <div class="text-xs text-[#5a8078] mt-2">Представитель: <%= property.user&.email || 'не указан' %></div>
                  </div>
                  <span class="px-3 py-1 rounded-full text-xs font-bold bg-yellow-300/15 text-yellow-300">
                    На проверке
                  </span>
                </div>

                <div class="mt-4 flex gap-3">
                  <%= button_to "Одобрить", admin_approve_property_path(property), method: :patch, class: "px-4 py-2 rounded-xl bg-[#1db896] text-[#050f0c] font-bold text-sm border-0 cursor-pointer" %>
                  <%= button_to "Отклонить", admin_reject_property_path(property), method: :patch, class: "px-4 py-2 rounded-xl bg-red-400/85 text-white font-bold text-sm border-0 cursor-pointer" %>
                </div>
              </div>
            <% end %>
          </div>
        <% else %>
          <div class="rounded-2xl border border-dashed border-white/10 bg-[#091410] p-6 text-sm text-[#9bbdb5]">
            Новых заявок по жилью на модерации нет.
          </div>
        <% end %>
      </section>
    </div>
  </div>
</body>
</html>
```

---

## `app/views/devise/registrations/new.html.erb`

```
<div class="relative z-10 flex flex-col min-h-screen bg-bg text-tx">
  <canvas id="aurora"></canvas>

  <header class="glass-hdr sticky top-0 z-50 flex items-center justify-between px-4 sm:px-6 lg:px-10 py-3">
    <%= link_to root_path, class: "cursor-pointer", data: { turbo: false } do %>
      <svg width="108" height="29" viewBox="0 0 240 60" fill="none">
        <path d="M44 10 C24 10 8 21 8 35 C8 49 24 56 44 56" stroke="#1db896" stroke-width="7" stroke-linecap="round" fill="none"/>
        <ellipse cx="9" cy="35" rx="7" ry="9" fill="#1db896"/>
        <path d="M9 44 L6 53 L9 49 L12 53 Z" fill="#1db896"/>
        <circle cx="9" cy="33" r="3" fill="#050f0c"/>
        <rect x="8" y="35.5" width="2" height="4" rx="1" fill="#050f0c"/>
        <path d="M56 12 L56 48 M56 30 Q63 21 73 30 L73 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        <path d="M82 36 Q82 24 93 24 Q103 24 103 33 L82 33 M82 36 Q82 48 93 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        <path d="M130 28 Q120 20 111 33 Q102 46 114 47 Q122 47 130 40" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        <path d="M150 24 Q137 24 137 35 Q137 47 150 47 Q163 47 163 35 Q163 28 158 25 M161 44 L170 54" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        <circle cx="178" cy="18" r="4" fill="#1db896"/>
        <line x1="178" y1="27" x2="178" y2="48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round"/>
        <path d="M188 48 L188 27 Q188 27 198 38 Q208 48 208 48 L208 27" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
      </svg>
    <% end %>

    <div class="text-xs text-tx3 hidden sm:block">
      Уже есть аккаунт?
      <%= link_to "Войти",
                  new_user_session_path,
                  class: "text-tl font-semibold cursor-pointer hover:underline",
                  data: { turbo: false } %>
    </div>
  </header>

  <main class="flex-1 flex items-center justify-center px-4 py-10 lg:py-14">
    <div class="w-full max-w-[480px] mx-auto">
      <div class="glass rounded-[26px] p-6 sm:p-8 shadow-[0_28px_80px_rgba(0,0,0,.5)]">
        <% supervisor_signup = params[:account_type] == 'supervisor' %>
        <div class="mb-6">
          <h2 class="font-serif text-tx mb-1.5" style="font-size:clamp(28px,3vw,36px)">
            <%= supervisor_signup ? "Регистрация супервайзора" : "Создайте аккаунт" %>
          </h2>
          <p class="text-tx2 text-sm" style="line-height:1.4">
            <%= supervisor_signup ? "Создайте аккаунт, чтобы добавлять и вести свои объекты размещения." : "Чтобы сохранять избранное и управлять данными бронирований." %>
          </p>
        </div>

        <% if resource.errors.any? %>
          <div class="mb-4 px-4 py-3 rounded-[11px] text-sm font-medium flex items-center gap-2" style="background:rgba(242,79,107,.1);border:1px solid rgba(242,79,107,.25);color:#f87171">
            <svg class="w-4 h-4 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
            </svg>
            <div>
              <% resource.errors.each do |error| %>
                <% translated_message = case [error.attribute, error.type]
                  when [:email, :blank]
                    "Введите электронную почту"
                  when [:email, :taken]
                    "Пользователь с такой почтой уже существует"
                  when [:email, :invalid]
                    "Введите электронную почту в правильном формате"
                  when [:password, :blank]
                    "Введите пароль"
                  when [:password, :too_short]
                    "Пароль должен содержать минимум 6 символов"
                  when [:password_confirmation, :confirmation]
                    "Подтверждение пароля не совпадает"
                  when [:password_confirmation, :blank]
                    "Подтвердите пароль"
                  else
                    error.full_message
                  end %>
                <div><%= translated_message %></div>
              <% end %>
            </div>
          </div>
        <% end %>

        <%= form_for(resource, as: resource_name, url: registration_path(resource_name, account_type: params[:account_type]), html: { class: "w-full" }) do |f| %>
          <%= hidden_field_tag :account_type, params[:account_type] if supervisor_signup %>
          <div class="mb-1.5 text-[9px] font-extrabold tracking-[1.8px] uppercase text-tx3">Электронная почта</div>
          <div class="relative mb-4">
            <%= f.email_field :email, autofocus: true, autocomplete: "email", placeholder: "example@mail.ru", class: "f-inp" %>
          </div>

          <div class="mb-1.5 text-[9px] font-extrabold tracking-[1.8px] uppercase text-tx3">Пароль</div>
          <div class="relative mb-3">
            <%= f.password_field :password, autocomplete: "new-password", placeholder: "Минимум 6 символов", class: "f-inp" %>
          </div>

          <div class="mb-1.5 text-[9px] font-extrabold tracking-[1.8px] uppercase text-tx3">Подтверждение пароля</div>
          <div class="relative mb-6">
            <%= f.password_field :password_confirmation, autocomplete: "new-password", placeholder: "Повторите пароль", class: "f-inp" %>
          </div>

          <%= f.submit "Зарегистрироваться",
                       class: "w-full py-4 rounded-[16px] border-none text-bg font-extrabold text-sm tracking-wide flex items-center justify-center gap-2 cursor-pointer transition-all",
                       style: "background:linear-gradient(135deg,#1db896,#15a07f,#0d7a60);box-shadow:0 8px 30px rgba(29,184,150,.35)" %>
        <% end %>

        <div class="text-center mt-5 text-sm text-tx3">
          <% if supervisor_signup %>
            Уже есть аккаунт?
            <%= link_to "Войти как супервайзор", new_user_session_path, class: "text-tl font-semibold cursor-pointer hover:underline", data: { turbo: false } %>
          <% else %>
            Нажимая «Зарегистрироваться», вы соглашаетесь с
            <span class="text-tl cursor-pointer hover:underline">условиями</span> и
            <span class="text-tl cursor-pointer hover:underline">политикой конфиденциальности</span>.
          <% end %>
        </div>
      </div>
    </div>
  </main>
</div>

<script>
  (function () {
    const c = document.getElementById('aurora');
    if (!c) return;
    const ctx = c.getContext('2d');
    let W, H, t = 0;
    const orbs = [
      { x: 0.15, y: 0.25, r: 0.4, col: 'rgba(29,184,150,.15)', sp: 0.0003 },
      { x: 0.85, y: 0.15, r: 0.32, col: 'rgba(29,184,150,.10)', sp: 0.0005 },
      { x: 0.50, y: 0.80, r: 0.38, col: 'rgba(13,122,96,.12)', sp: 0.0002 },
      { x: 0.90, y: 0.70, r: 0.28, col: 'rgba(29,184,150,.09)', sp: 0.0006 }
    ];
    function resize() { W = c.width = window.innerWidth; H = c.height = window.innerHeight; }
    resize();
    window.addEventListener('resize', resize);
    function draw() {
      ctx.clearRect(0, 0, W, H);
      orbs.forEach(o => {
        const ox = W * (o.x + 0.07 * Math.sin(t * o.sp * 3));
        const oy = H * (o.y + 0.05 * Math.cos(t * o.sp * 2));
        const r = Math.min(W, H) * o.r;
        const g = ctx.createRadialGradient(ox, oy, 0, ox, oy, r);
        g.addColorStop(0, o.col);
        g.addColorStop(1, 'rgba(0,0,0,0)');
        ctx.fillStyle = g;
        ctx.beginPath();
        ctx.arc(ox, oy, r, 0, Math.PI * 2);
        ctx.fill();
      });
      t++;
      requestAnimationFrame(draw);
    }
    draw();
  })();
</script>
```

---

## `app/views/devise/sessions/new.html.erb`

```
<div class="relative z-10 flex flex-col min-h-screen bg-bg text-tx overflow-x-hidden">
  <canvas id="aurora"></canvas>

  <header class="glass-hdr sticky top-0 z-50 flex items-center justify-between px-4 sm:px-6 lg:px-10 py-3">
    <%= link_to root_path, class: "cursor-pointer", data: { turbo: false } do %>
      <svg width="108" height="29" viewBox="0 0 240 60" fill="none">
        <path d="M44 10 C24 10 8 21 8 35 C8 49 24 56 44 56" stroke="#1db896" stroke-width="7" stroke-linecap="round" fill="none"/>
        <ellipse cx="9" cy="35" rx="7" ry="9" fill="#1db896"/>
        <path d="M9 44 L6 53 L9 49 L12 53 Z" fill="#1db896"/>
        <circle cx="9" cy="33" r="3" fill="#050f0c"/>
        <rect x="8" y="35.5" width="2" height="4" rx="1" fill="#050f0c"/>
        <path d="M56 12 L56 48 M56 30 Q63 21 73 30 L73 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        <path d="M82 36 Q82 24 93 24 Q103 24 103 33 L82 33 M82 36 Q82 48 93 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        <path d="M130 28 Q120 20 111 33 Q102 46 114 47 Q122 47 130 40" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        <path d="M150 24 Q137 24 137 35 Q137 47 150 47 Q163 47 163 35 Q163 28 158 25 M161 44 L170 54" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        <circle cx="178" cy="18" r="4" fill="#1db896"/>
        <line x1="178" y1="27" x2="178" y2="48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round"/>
        <path d="M188 48 L188 27 Q188 27 198 38 Q208 48 208 48 L208 27" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
      </svg>
    <% end %>

    <div class="text-xs text-tx3 hidden sm:block">
      Нет аккаунта?
      <%= link_to "Регистрация", new_user_registration_path, class: "text-tl font-semibold cursor-pointer hover:underline", data: { turbo: false } %>
      ·
      <%= link_to "Стать супервайзором", new_user_registration_path(account_type: :supervisor), class: "text-tl font-semibold cursor-pointer hover:underline", data: { turbo: false } %>
    </div>
  </header>

  <main class="flex-1 flex items-center justify-center px-4 py-10 lg:py-14">
    <div class="w-full max-w-[480px] mx-auto">
      <div class="glass rounded-[26px] p-6 sm:p-8 shadow-[0_28px_80px_rgba(0,0,0,.5)]">
        <div class="mb-6">
          <h2 class="font-serif text-tx mb-2" style="font-size:clamp(28px,3vw,36px)">Вход</h2>
          <p class="text-tx2 text-sm" style="line-height:1.4">Введите email и пароль, чтобы продолжить.</p>
        </div>

        <% if alert.present? %>
          <div class="mb-4 px-4 py-3 rounded-[11px] text-sm font-medium flex items-center gap-2"
               style="background:rgba(242,79,107,.1);border:1px solid rgba(242,79,107,.25);color:#f87171">
            <svg class="w-4 h-4 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
            </svg>
            <span><%= alert %></span>
          </div>
        <% end %>

        <%= form_for(resource, as: resource_name, url: session_path(resource_name), html: { class: "w-full" }) do |f| %>
          <div class="mb-1.5 text-[9px] font-extrabold tracking-[1.8px] uppercase text-tx3">Электронная почта</div>
          <div class="relative mb-4">
            <%= f.email_field :email,
                               id: "l-em",
                               autofocus: true,
                               autocomplete: "email",
                               placeholder: "example@mail.ru",
                               class: "f-inp" %>
            <span class="absolute right-3.5 top-1/2 -translate-y-1/2 text-tx3 pointer-events-none">
              <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
              </svg>
            </span>
          </div>

          <div class="mb-1.5 text-[9px] font-extrabold tracking-[1.8px] uppercase text-tx3">Пароль</div>
          <div class="relative mb-3">
            <%= f.password_field :password,
                                  id: "l-pw",
                                  autocomplete: "current-password",
                                  placeholder: "••••••••",
                                  class: "f-inp" %>
            <button type="button"
                    onclick="tgPass('l-pw')"
                    class="absolute right-3.5 top-1/2 -translate-y-1/2 text-tx3 hover:text-tl transition-colors">
              <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                <path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
              </svg>
            </button>
          </div>

          <div class="flex items-center justify-between mb-6">
            <label class="flex items-center gap-2 cursor-pointer select-none">
              <%= f.check_box :remember_me, id: "l-rem", class: "hidden" %>
              <div class="cb-box" id="l-rem-box" onclick="tgCb('l-rem')">
                <svg id="l-rem-ico" class="w-3 h-3 text-bg hidden" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="3">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/>
                </svg>
              </div>
              <span class="text-sm text-tx2">Запомнить меня</span>
            </label>

            <%= link_to "Забыли пароль?", new_password_path(resource_name), class: "text-sm text-tl font-semibold hover:underline", data: { turbo: false } %>
          </div>

          <%= f.submit "Войти",
                        class: "w-full py-4 rounded-[16px] border-none text-bg font-extrabold text-sm tracking-wide flex items-center justify-center gap-2 cursor-pointer transition-all",
                        style: "background:linear-gradient(135deg,#1db896,#15a07f,#0d7a60);box-shadow:0 8px 30px rgba(29,184,150,.35)" %>

          <div class="text-center mt-5 text-sm text-tx3">
            Нет аккаунта?
            <%= link_to "Зарегистрироваться", new_user_registration_path, class: "text-tl font-semibold cursor-pointer hover:underline", data: { turbo: false } %>
          </div>
          <div class="text-center mt-2 text-sm text-tx3">
            Хотите добавлять свои объекты?
            <%= link_to "Регистрация супервайзора", new_user_registration_path(account_type: :supervisor), class: "text-tl font-semibold cursor-pointer hover:underline", data: { turbo: false } %>
          </div>
        <% end %>
      </div>
    </div>
  </main>
</div>

<script>
function tgPass(inputId){
  const i=document.getElementById(inputId);
  if(!i) return;
  i.type = (i.type === 'password') ? 'text' : 'password';
}

function tgCb(id){
  const cb=document.getElementById(id);
  const box=document.getElementById(id+'-box');
  const ico=document.getElementById(id+'-ico');
  if(!cb || !box) return;
  cb.checked = !cb.checked;
  box.classList.toggle('checked', cb.checked);
  if(ico) ico.classList.toggle('hidden', !cb.checked);
}

(function(){
  const cb=document.getElementById('l-rem');
  if(!cb) return;
  const box=document.getElementById('l-rem-box');
  const ico=document.getElementById('l-rem-ico');
  box && box.classList.toggle('checked', cb.checked);
  ico && ico.classList.toggle('hidden', !cb.checked);
})();
(function(){
  const c=document.getElementById('aurora');
  if(!c) return;
  const ctx=c.getContext('2d');
  let W,H,t=0;
  const orbs=[
    {x:.15,y:.25,r:.4,col:'rgba(29,184,150,.15)',sp:.0003},
    {x:.85,y:.15,r:.32,col:'rgba(29,184,150,.10)',sp:.0005},
    {x:.5,y:.8,r:.38,col:'rgba(13,122,96,.12)',sp:.0002},
    {x:.9,y:.7,r:.28,col:'rgba(29,184,150,.09)',sp:.0006}
  ];
  function resize(){W=c.width=window.innerWidth;H=c.height=window.innerHeight}
  resize();window.addEventListener('resize',resize);
  function draw(){
    ctx.clearRect(0,0,W,H);
    orbs.forEach(o=>{
      const ox=W*(o.x+.07*Math.sin(t*o.sp*3));
      const oy=H*(o.y+.05*Math.cos(t*o.sp*2));
      const r=Math.min(W,H)*o.r;
      const g=ctx.createRadialGradient(ox,oy,0,ox,oy,r);
      g.addColorStop(0,o.col);
      g.addColorStop(1,'rgba(0,0,0,0)');
      ctx.fillStyle=g;
      ctx.beginPath();
      ctx.arc(ox,oy,r,0,Math.PI*2);
      ctx.fill();
    });
    t++;
    requestAnimationFrame(draw);
  }
  draw();
})();
</script>
```

---

## `app/views/favorites/show.html.erb`

```
<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checqin — Избранное</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<script>
tailwind.config = {
  theme: {
    extend: {
      colors: {
        tl:'#1db896',tl2:'#15a07f',tl3:'#0d7a60',
        bg:'#050f0c',bg2:'#091410',bg3:'#0d1c18',bg4:'#122720',
        tx:'#e8f5f1',tx2:'#9bbdb5',tx3:'#5a8078',
      },
      fontFamily: {
        serif:['"DM Serif Display"','serif'],
        sans:['"Plus Jakarta Sans"','sans-serif'],
      },
    }
  }
}
</script>
<style>
*,*::before,*::after{box-sizing:border-box}
body{font-family:'Plus Jakarta Sans',sans-serif;margin:0}
#aurora{position:fixed;inset:0;z-index:0;pointer-events:none;opacity:.5}
.glass-hdr{background:rgba(5,15,12,.82);backdrop-filter:blur(20px);border-bottom:1px solid rgba(29,184,150,.15)}
.hcard-wrap:hover .hcard-photo{transform:scale(1.05)}
.hcard-photo{transition:transform .4s;width:100%;height:100%;object-fit:cover;display:block}
@media(min-width:1280px){.hotels-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:20px}}
@media(min-width:768px) and (max-width:1023px){.hotels-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:16px}}
@media(max-width:767px){.hotels-grid{display:flex;flex-direction:column;gap:16px}}
</style>
</head>
<body class="bg-bg min-h-screen text-tx overflow-x-hidden">
<canvas id="aurora"></canvas>

<div class="relative z-10 flex flex-col min-h-screen">
  <header class="glass-hdr sticky top-0 z-50 flex items-center justify-between px-4 sm:px-6 lg:px-8 py-3 lg:py-4">
    <div class="flex items-center gap-2 cursor-pointer flex-shrink-0" onclick="window.location.href='/'">
      <svg width="110" height="30" viewBox="0 0 240 60" fill="none">
        <path d="M44 10 C24 10 8 21 8 35 C8 49 24 56 44 56" stroke="#1db896" stroke-width="7" stroke-linecap="round" fill="none"/>
        <ellipse cx="9" cy="35" rx="7" ry="9" fill="#1db896"/>
        <path d="M9 44 L6 53 L9 49 L12 53 Z" fill="#1db896"/>
        <circle cx="9" cy="33" r="3" fill="#050f0c"/>
        <rect x="8" y="35.5" width="2" height="4" rx="1" fill="#050f0c"/>
        <path d="M56 12 L56 48 M56 30 Q63 21 73 30 L73 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        <path d="M82 36 Q82 24 93 24 Q103 24 103 33 L82 33 M82 36 Q82 48 93 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/>
        <path d="M130 28 Q120 20 111 33 Q102 46 114 47 Q122 47 130 40" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/>
        <path d="M150 24 Q137 24 137 35 Q137 47 150 47 Q163 47 163 35 Q163 28 158 25 M161 44 L170 54" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/>
        <circle cx="178" cy="18" r="4" fill="#1db896"/>
        <line x1="178" y1="27" x2="178" y2="48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round"/>
        <path d="M188 48 L188 27 Q188 27 198 38 Q208 48 208 48 L208 27" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
      </svg>
    </div>
    <nav class="hidden lg:flex items-center gap-6 text-sm font-semibold text-tx2">
      <span class="hover:text-tl cursor-pointer transition-colors" onclick="window.location.href='/'">Главная</span>
      <span class="hover:text-tl cursor-pointer transition-colors" onclick="window.location.href='/search'">Все отели</span>
      <span class="hover:text-tl cursor-pointer transition-colors" onclick="window.location.href='/favorites'">Избранное</span>
      <% if user_signed_in? %>
        <% if current_user.supervisor? %>
          <span class="hover:text-tl cursor-pointer transition-colors" onclick="window.location.href='/supervisor'">Супервайзор</span>
        <% end %>
        <%= button_to "Выйти",
                      destroy_user_session_path,
                      method: :delete,
                      class: "hover:text-tl cursor-pointer transition-colors bg-transparent border-none p-0 font-semibold text-sm",
                      form: { data: { turbo: false } } %>
      <% else %>
        <%= link_to "Войти",
                    new_user_session_path,
                    class: "hover:text-tl cursor-pointer transition-colors text-sm font-semibold text-tx2",
                    data: { turbo: false } %>
      <% end %>
    </nav>
    <div class="flex items-center gap-2">
      <button onclick="window.location.href='/favorites'" title="Избранное" class="w-9 h-9 lg:w-10 lg:h-10 rounded-xl border border-white/10 bg-white/[.04] flex items-center justify-center text-tl cursor-pointer transition-all hover:border-tl hover:text-tl hover:bg-tl/10">
        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/></svg>
      </button>
    </div>
  </header>
  <div class="glass-hdr sticky top-0 z-10 flex items-center gap-3 px-4 sm:px-6 lg:px-8 py-3 lg:py-4">
    <button onclick="window.location.href='/'"
      class="w-9 h-9 rounded-[11px] border border-white/10 bg-white/[.04] text-tx2 flex items-center justify-center flex-shrink-0 transition-all hover:border-tl hover:text-tl">
      <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/></svg>
    </button>
    <div>
      <div class="font-bold text-tx" style="font-size:clamp(15px,1.6vw,18px)">Избранное</div>
      <div class="text-tx3 mt-0.5" id="fav-count" style="font-size:clamp(10px,1.1vw,12px)"><%= @favorites.count %> отель сохранен</div>
    </div>
  </div>
  <div class="px-4 sm:px-6 lg:px-8 xl:px-10 pt-4 pb-10 hotels-grid" id="favorites-grid">
    <% if @favorites.any? %>
      <% @favorites.each do |favorite| %>
        <% hotel = favorite.hotel %>
        <div class="hcard-wrap rounded-[20px] overflow-hidden bg-bg3 border border-white/8 transition-all duration-300 hover:-translate-y-1" style="box-shadow:0 2px 14px rgba(0,0,0,.22)">
          <div style="position:relative;height:185px;overflow:hidden;background:#122720">
            <% if hotel.photos.attached? && hotel.photos.first.present? %>
              <img class="hcard-photo" src="<%= url_for(hotel.photos.first) %>" alt="<%= hotel.name %>" loading="lazy"
                style="width:100%;height:100%;object-fit:cover;display:block">
            <% else %>
              <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;font-size:52px;background:linear-gradient(135deg,#122720,#0d1c18)">🏨</div>
            <% end %>
            <button id="hf-<%= hotel.id %>" onclick="toggleFav(<%= hotel.id %>)"
              style="position:absolute;top:12px;right:12px;width:34px;height:34px;border-radius:50%;border:none;background:rgba(5,15,12,.75);backdrop-filter:blur(8px);cursor:pointer;display:flex;align-items:center;justify-content:center;transition:all .2s">
              <svg style="width:16px;height:16px" fill="#f87171" viewBox="0 0 24 24" stroke="#f87171" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/></svg>
            </button>
          </div>
          <div class="p-4 sm:p-5">
            <div class="flex items-center justify-between mb-2">
              <div style="color:#f5c842;font-size:clamp(10px,1.1vw,13px);letter-spacing:1px"><%= "★" * hotel.rating.to_i %><%= "☆" * (5 - hotel.rating.to_i) %></div>
              <div style="background:#1db896;color:#050f0c;font-weight:800;font-size:clamp(11px,1.1vw,13px);padding:4px 9px;border-radius:8px"><%= hotel.rating || 4.5 %></div>
            </div>
            <div class="font-bold text-tx mb-1 leading-snug" style="font-size:clamp(13px,1.4vw,16px)"><%= link_to hotel.name, hotel_path(hotel), style: "color: #e8f5f1; text-decoration: none;" %></div>
            <div class="flex items-center gap-1.5 text-tx3 mb-3.5" style="font-size:clamp(11px,1.1vw,13px)">
              <svg style="width:11px;height:11px;color:#1db896;flex-shrink:0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
              <%= hotel.city %>, <%= hotel.address %>
            </div>
            <div class="text-tx3 mb-3.5" style="font-size:clamp(10px,1vw,12px)">Доступно: <%= hotel.availability_label %></div>
            <div class="flex items-end justify-between">
              <div>
                <div class="font-serif text-tx leading-none" style="font-size:clamp(20px,2.2vw,26px)">₽<%= hotel.display_price.to_i %></div>
                <div class="text-tx3 mt-1" style="font-size:clamp(10px,1vw,12px)">за ночь · от 1 гостя</div>
              </div>
              <button onclick="window.location.href='/hotels/<%= hotel.id %>'"
                class="rounded-[12px] border-none text-bg font-extrabold cursor-pointer transition-all hover:-translate-y-0.5"
                style="padding:clamp(9px,1vw,12px) clamp(14px,1.5vw,20px);background:linear-gradient(135deg,#1db896,#15a07f);box-shadow:0 6px 20px rgba(29,184,150,.3);font-size:clamp(11px,1.2vw,14px)">
                Подробнее
              </button>
            </div>
          </div>
        </div>
      <% end %>
    <% else %>
      <div class="flex flex-col items-center justify-center flex-1 px-8 py-20 text-center">
        <div class="rounded-[28px] border border-tl/20 bg-tl/10 flex items-center justify-center text-tl mb-6 mx-auto" style="width:clamp(72px,8vw,96px);height:clamp(72px,8vw,96px)">
          <svg style="width:40%;height:40%" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/></svg>
        </div>
        <h3 class="font-serif text-tx mb-2.5" style="font-size:clamp(20px,2.2vw,28px)">Пока ничего нет</h3>
        <p class="text-tx2 leading-[1.7] max-w-[280px]" style="font-size:clamp(12px,1.2vw,14px)">Нажмите ♡ на карточке отеля, чтобы сохранить его сюда.</p>
      </div>
    <% end %>
  </div>
</div>

<script>
(function(){
  const c=document.getElementById('aurora'),ctx=c.getContext('2d');
  let W,H,t=0;
  const orbs=[
    {x:.2,y:.3,r:.38,col:'rgba(29,184,150,.18)',sp:.0003},
    {x:.8,y:.1,r:.3,col:'rgba(29,184,150,.12)',sp:.0005},
    {x:.5,y:.75,r:.42,col:'rgba(13,122,96,.13)',sp:.0002},
    {x:.1,y:.9,r:.25,col:'rgba(29,184,150,.1)',sp:.0006},
  ];
  function resize(){W=c.width=window.innerWidth;H=c.height=window.innerHeight}
  resize();window.addEventListener('resize',resize);
  function draw(){
    ctx.clearRect(0,0,W,H);
    orbs.forEach(o=>{
      const ox=W*(o.x+.08*Math.sin(t*o.sp*3));
      const oy=H*(o.y+.06*Math.cos(t*o.sp*2));
      const r=Math.min(W,H)*o.r;
      const g=ctx.createRadialGradient(ox,oy,0,ox,oy,r);
      g.addColorStop(0,o.col);g.addColorStop(1,'rgba(0,0,0,0)');
      ctx.fillStyle=g;ctx.beginPath();ctx.arc(ox,oy,r,0,Math.PI*2);ctx.fill();
    });
    t++;requestAnimationFrame(draw);
  }
  draw();
})();

function toggleFav(id){
  fetch('/favorites/toggle/' + id, {
    method: 'POST',
    headers: {
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      'Content-Type': 'application/json'
    }
  }).then(() => {
    location.reload();
  });
}

function applyHotelsGrid(){
  const w=window.innerWidth;
  const el=document.getElementById('favorites-grid');
  if(!el)return;
  if(w>=1280){el.style.display='grid';el.style.gridTemplateColumns='repeat(3,1fr)';el.style.gap='20px';el.style.flexDirection=''}
  else if(w>=768){el.style.display='grid';el.style.gridTemplateColumns='repeat(2,1fr)';el.style.gap='16px';el.style.flexDirection=''}
  else{el.style.display='flex';el.style.flexDirection='column';el.style.gap='16px';}
}
window.addEventListener('resize',applyHotelsGrid);
applyHotelsGrid();
</script>
</body>
</html>
```

---

## `app/views/hotels/create.html.erb`

```
<h1>Hotels#create</h1>
<p>Find me in app/views/hotels/create.html.erb</p>
```

---

## `app/views/hotels/destroy.html.erb`

```
<h1>Hotels#destroy</h1>
<p>Find me in app/views/hotels/destroy.html.erb</p>
```

---

## `app/views/hotels/edit.html.erb`

```
<h1>Hotels#edit</h1>
<p>Find me in app/views/hotels/edit.html.erb</p>
```

---

## `app/views/hotels/index.html.erb`

```
<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checqin — Найди свой отель</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<script>
tailwind.config = {
  theme: {
    extend: {
      colors: {
        tl:'#1db896',tl2:'#15a07f',tl3:'#0d7a60',
        bg:'#050f0c',bg2:'#091410',bg3:'#0d1c18',bg4:'#122720',
        tx:'#e8f5f1',tx2:'#9bbdb5',tx3:'#5a8078',
      },
      fontFamily: {
        serif:['"DM Serif Display"','serif'],
        sans:['"Plus Jakarta Sans"','sans-serif'],
      },
      keyframes: {
        pulse2:{'0%,100%':{opacity:'1',transform:'scale(1)'},'50%':{opacity:'.4',transform:'scale(.7)'}},
        fadeUp:{from:{opacity:'0',transform:'translateY(14px)'},to:{opacity:'1',transform:'translateY(0)'}},
        drawerIn:{from:{transform:'translateX(100%)'},to:{transform:'translateX(0)'}},
        sheetUp:{from:{transform:'translateY(60%)',opacity:'0'},to:{transform:'translateY(0)',opacity:'1'}},
      },
      animation:{
        pulse2:'pulse2 2s ease-in-out infinite',
        fadeUp:'fadeUp .38s ease',
        drawerIn:'drawerIn .28s cubic-bezier(.32,0,.15,1)',
        sheetUp:'sheetUp .32s cubic-bezier(.34,1.1,.64,1)',
      },
      screens:{
        xs:'400px',
      }
    }
  }
}
</script>
<style>
*,*::before,*::after{box-sizing:border-box}
body{font-family:'Plus Jakarta Sans',sans-serif;margin:0}
#aurora{position:fixed;inset:0;z-index:0;pointer-events:none;opacity:.5}
.pg{display:none}
.pg.on{display:flex;flex-direction:column;flex:1;animation:fadeUp .38s ease}
@keyframes fadeUp{from{opacity:0;transform:translateY(14px)}to{opacity:1;transform:translateY(0)}}
.no-sb::-webkit-scrollbar{display:none}
.no-sb{-ms-overflow-style:none;scrollbar-width:none}
.glass{background:rgba(13,28,24,.88);backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);border:1px solid rgba(29,184,150,.18)}
.glass-hdr{background:rgba(5,15,12,.82);backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);border-bottom:1px solid rgba(29,184,150,.15)}
.f-in{
  width:100%;padding:13px 16px;border:1px solid rgba(255,255,255,.08);
  border-radius:14px;background:rgba(255,255,255,.04);color:#e8f5f1;
  font-family:'Plus Jakarta Sans',sans-serif;font-size:clamp(13px,1.5vw,15px);
  font-weight:500;outline:none;transition:all .2s;
}
.f-in:focus{border-color:#1db896;background:rgba(255,255,255,.07);box-shadow:0 0 0 3px rgba(29,184,150,.2)}
.f-in::placeholder{color:#5a8078}
.d-btn{
  width:100%;padding:12px 14px;border:1px solid rgba(255,255,255,.08);
  border-radius:14px;background:rgba(255,255,255,.04);color:#e8f5f1;
  font-family:'Plus Jakarta Sans',sans-serif;font-size:clamp(12px,1.4vw,14px);
  font-weight:500;cursor:pointer;text-align:left;
  display:flex;align-items:center;gap:9px;transition:all .2s;outline:none;
}
.d-btn:hover,.d-btn:focus{border-color:#1db896;background:rgba(255,255,255,.07)}
.ft{flex-shrink:0;padding:8px 18px;border-radius:20px;border:1px solid rgba(255,255,255,.1);background:rgba(255,255,255,.04);font-size:clamp(11px,1.3vw,13px);font-weight:600;color:#9bbdb5;cursor:pointer;white-space:nowrap;font-family:inherit;transition:all .2s}
.ft.on{background:#1db896;border-color:#1db896;color:#050f0c}
.cd{
  aspect-ratio:1;display:flex;align-items:center;justify-content:center;
  font-size:clamp(11px,1.4vw,14px);font-weight:500;border-radius:9px;
  cursor:pointer;border:none;background:transparent;
  color:#e8f5f1;font-family:'Plus Jakarta Sans',sans-serif;transition:all .15s;
}
.cd:hover:not(.dis):not(.emp){background:rgba(255,255,255,.07);color:#1db896}
.cd.sel{background:#1db896!important;color:#050f0c!important;font-weight:800;box-shadow:0 4px 14px rgba(29,184,150,.4)}
.cd.rng{background:rgba(29,184,150,.12);color:#1db896}
.cd.dis{color:#5a8078;opacity:.35;cursor:not-allowed}
.cd.emp{cursor:default}
.cd.td:not(.sel){color:#1db896;font-weight:800}
.hcard-wrap:hover .hcard-photo{transform:scale(1.05)}
.hcard-photo{transition:transform .4s;width:100%;height:100%;object-fit:cover;display:block}
@media(min-width:1024px){
  .desktop-2col{display:grid;grid-template-columns:380px 1fr;gap:0;min-height:100vh}
  .sidebar-panel{position:sticky;top:0;height:100vh;overflow-y:auto;border-right:1px solid rgba(29,184,150,.12)}
  .hotels-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:20px}
}
@media(min-width:1280px){
  .hotels-grid{grid-template-columns:repeat(3,1fr)}
}
@media(min-width:768px) and (max-width:1023px){
  .hotels-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:16px}
}
</style>
</head>
<body class="bg-bg min-h-screen text-tx overflow-x-hidden">
<canvas id="aurora"></canvas>
<div class="relative z-10 flex flex-col min-h-screen">
  <header class="glass-hdr sticky top-0 z-50 flex items-center justify-between px-4 sm:px-6 lg:px-8 py-3 lg:py-4">
    <div class="flex items-center gap-2 cursor-pointer flex-shrink-0" onclick="window.location.href='/'">
      <svg width="110" height="30" viewBox="0 0 240 60" fill="none">
        <path d="M44 10 C24 10 8 21 8 35 C8 49 24 56 44 56" stroke="#1db896" stroke-width="7" stroke-linecap="round" fill="none"/>
        <ellipse cx="9" cy="35" rx="7" ry="9" fill="#1db896"/>
        <path d="M9 44 L6 53 L9 49 L12 53 Z" fill="#1db896"/>
        <circle cx="9" cy="33" r="3" fill="#050f0c"/>
        <rect x="8" y="35.5" width="2" height="4" rx="1" fill="#050f0c"/>
        <path d="M56 12 L56 48 M56 30 Q63 21 73 30 L73 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        <path d="M82 36 Q82 24 93 24 Q103 24 103 33 L82 33 M82 36 Q82 48 93 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/>
        <path d="M130 28 Q120 20 111 33 Q102 46 114 47 Q122 47 130 40" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/>
        <path d="M150 24 Q137 24 137 35 Q137 47 150 47 Q163 47 163 35 Q163 28 158 25 M161 44 L170 54" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/>
        <circle cx="178" cy="18" r="4" fill="#1db896"/>
        <line x1="178" y1="27" x2="178" y2="48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round"/>
        <path d="M188 48 L188 27 Q188 27 198 38 Q208 48 208 48 L208 27" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
      </svg>
    </div>
    <nav class="hidden lg:flex items-center gap-6 text-sm font-semibold text-tx2">
      <span class="hover:text-tl cursor-pointer transition-colors" onclick="window.location.href='/'">Главная</span>
      <span class="hover:text-tl cursor-pointer transition-colors" onclick="doSearch()">Все отели</span>
      <span class="hover:text-tl cursor-pointer transition-colors" onclick="window.location.href='/favorites'">Избранное</span>
      <% if user_signed_in? %>
        <% if current_user.supervisor? %>
          <span class="hover:text-tl cursor-pointer transition-colors" onclick="window.location.href='/supervisor'">Супервайзор</span>
        <% end %>
        <%= button_to "Выйти",
                      destroy_user_session_path,
                      method: :delete,
                      class: "hover:text-tl cursor-pointer transition-colors bg-transparent border-none p-0 font-semibold text-sm",
                      form: { data: { turbo: false } } %>
      <% else %>
        <%= link_to "Войти",
                    new_user_session_path,
                    class: "hover:text-tl cursor-pointer transition-colors text-sm font-semibold text-tx2",
                    data: { turbo: false } %>
      <% end %>
    </nav>

    <div class="flex items-center gap-2">
      <button id="ni-fav" onclick="window.location.href='/favorites'" title="Избранное"
        class="w-9 h-9 lg:w-10 lg:h-10 rounded-xl border border-white/10 bg-white/[.04] flex items-center justify-center text-tx2 cursor-pointer transition-all hover:border-tl hover:text-tl hover:bg-tl/10">
        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/></svg>
      </button>
      <button onclick="openMenu()"
        class="w-9 h-9 lg:w-10 lg:h-10 rounded-xl border border-white/10 bg-white/[.04] flex items-center justify-center text-tx2 cursor-pointer transition-all hover:border-tl hover:text-tl hover:bg-tl/10">
        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M4 6h16M4 12h16M4 18h16"/></svg>
      </button>
    </div>
  </header>
  <div class="pg on" id="pg-home">
    <div class="lg:grid lg:grid-cols-2 lg:gap-0 lg:min-h-[calc(100vh-62px)]">
      <div class="relative px-5 sm:px-8 lg:px-14 pt-10 sm:pt-14 pb-14 sm:pb-16 lg:pt-24 lg:pb-24 overflow-hidden flex flex-col justify-end lg:justify-center"
           style="background: radial-gradient(ellipse 80% 60% at 30% 50%,rgba(29,184,150,.22) 0%,transparent 70%), radial-gradient(ellipse 50% 50% at 90% 10%,rgba(29,184,150,.1) 0%,transparent 70%)">
        <h1 class="font-serif text-tx tracking-tight mb-3 leading-[1.18]"
            style="font-size:clamp(28px,4vw,52px)">
          Ваш идеальный<br>отель — <em class="text-tl not-italic">везде</em><br>в мире.
        </h1>
        <p class="text-tx2 leading-relaxed max-w-[420px]" style="font-size:clamp(13px,1.3vw,16px)">
          Ищите, сравнивайте и бронируйте лучшие отели<br class="hidden sm:block">с Checqin — умные путешествия, переосмыслённые.
        </p>
      </div>
      <div class="flex items-center justify-center px-4 sm:px-8 lg:px-10 pb-10 lg:py-16"
           style="background:rgba(9,20,16,.4)">
        <div class="glass rounded-[24px] sm:rounded-[28px] p-5 sm:p-7 lg:p-8 w-full max-w-[520px] shadow-[0_20px_60px_rgba(0,0,0,.4)] -mt-6 lg:mt-0 relative z-10">

          <h2 class="font-serif text-tx mb-5 hidden lg:block" style="font-size:clamp(20px,2vw,24px)">Найти жильё</h2>
          <%= form_tag search_hotels_path, method: :get, class: "search-form" do %>
            <div class="mb-4">
              <div class="text-[9px] font-extrabold tracking-[1.8px] uppercase text-tx3 mb-1.5">Куда едем?</div>
              <%= text_field_tag :city, params[:city], placeholder: "Город, отель или аэропорт…", class: "f-in", id: "dest" %>
            </div>
            <div class="grid grid-cols-2 gap-2.5 mb-4">
              <div>
                <div class="text-[9px] font-extrabold tracking-[1.8px] uppercase text-tx3 mb-1.5">Заезд</div>
                <button type="button" class="d-btn" id="ci-b" onclick="openCal('checkin')">
                  <svg class="w-3.5 h-3.5 text-tl flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>
                  <span id="ci-txt">23 мар, 2026</span>
                </button>
              </div>
              <div>
                <div class="text-[9px] font-extrabold tracking-[1.8px] uppercase text-tx3 mb-1.5">Выезд</div>
                <button type="button" class="d-btn" id="co-b" onclick="openCal('checkout')">
                  <svg class="w-3.5 h-3.5 text-tl flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>
                  <span id="co-txt">24 мар, 2026</span>
                </button>
              </div>
            </div>

            <%= hidden_field_tag :checkin, "", id: "checkin_hidden" %>
            <%= hidden_field_tag :checkout, "", id: "checkout_hidden" %>
            <%= hidden_field_tag :guests, "2", id: "guests_hidden" %>
            <div class="mb-5">
              <div class="text-[9px] font-extrabold tracking-[1.8px] uppercase text-tx3 mb-1.5">Гости</div>
              <div class="flex items-center justify-between px-4 py-3 border border-white/8 rounded-[14px] bg-white/[.04]">
                <div>
                  <div class="text-[10px] text-tx3 font-semibold tracking-wide">1 номер для</div>
                  <div class="font-bold text-tx mt-0.5" id="gv" style="font-size:clamp(13px,1.4vw,15px)">2 гостей</div>
                </div>
                <div class="flex items-center gap-3">
                  <button type="button" onclick="adjG(-1)" class="w-8 h-8 rounded-[10px] border border-tl/30 bg-white/[.04] text-tl text-lg flex items-center justify-center transition-all hover:bg-tl hover:text-bg hover:border-tl">−</button>
                  <span class="font-extrabold text-tx min-w-[20px] text-center" id="gn" style="font-size:clamp(14px,1.5vw,16px)">2</span>
                  <button type="button" onclick="adjG(1)" class="w-8 h-8 rounded-[10px] border border-tl/30 bg-white/[.04] text-tl text-lg flex items-center justify-center transition-all hover:bg-tl hover:text-bg hover:border-tl">+</button>
                </div>
              </div>
            </div>
            <button type="submit" id="srch-btn"
              class="w-full py-4 rounded-2xl border-none text-bg font-extrabold tracking-wide flex items-center justify-center gap-2 cursor-pointer transition-all"
              style="background:linear-gradient(135deg,#1db896 0%,#15a07f 60%,#0d7a60 100%);box-shadow:0 8px 30px rgba(29,184,150,.35);font-size:clamp(13px,1.4vw,15px)"
              onmouseover="this.style.transform='translateY(-2px)';this.style.boxShadow='0 14px 40px rgba(29,184,150,.45)'"
              onmouseout="this.style.transform='';this.style.boxShadow='0 8px 30px rgba(29,184,150,.35)'">
              <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
              Найти отели
            </button>
          <% end %>
        </div>
      </div>
    </div>

    <% if @hotels.any? %>
      <div class="px-4 sm:px-6 lg:px-10 py-8 lg:py-10 bg-bg">
        <div class="flex items-center justify-between mb-4 lg:mb-6">
          <div class="font-bold text-tx" style="font-size:clamp(16px,2vw,22px)">Новые отели</div>
          <div class="text-tl font-semibold cursor-pointer transition-all hover:opacity-75" style="font-size:clamp(11px,1.2vw,14px)" onclick="doSearch()">Смотреть все →</div>
        </div>
        <div class="grid md:grid-cols-2 xl:grid-cols-3 gap-4">
          <% @hotels.first(3).each do |hotel| %>
            <div class="hcard-wrap rounded-[20px] overflow-hidden bg-bg3 border border-white/8 transition-all duration-300 hover:-translate-y-1" style="box-shadow:0 2px 14px rgba(0,0,0,.22)">
              <div style="position:relative;height:185px;overflow:hidden;background:#122720">
                <% if hotel.photos.attached? && hotel.photos.first.present? %>
                  <img class="hcard-photo" src="<%= url_for(hotel.photos.first) %>" alt="<%= hotel.name %>" loading="lazy" style="width:100%;height:100%;object-fit:cover;display:block">
                <% else %>
                  <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;font-size:52px;background:linear-gradient(135deg,#122720,#0d1c18)">🏨</div>
                <% end %>
              </div>
              <div class="p-4 sm:p-5">
                <div class="font-bold text-tx mb-1 leading-snug" style="font-size:clamp(13px,1.4vw,16px)"><%= link_to hotel.name, hotel_path(hotel), style: "color: #e8f5f1; text-decoration: none;" %></div>
                <div class="flex items-center gap-1.5 text-tx3 mb-2.5" style="font-size:clamp(11px,1.1vw,13px)">
                  <svg style="width:11px;height:11px;color:#1db896;flex-shrink:0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                  <%= hotel.city %>, <%= hotel.address %>
                </div>
                <div class="text-tx3 mb-3.5" style="font-size:clamp(10px,1vw,12px)">Доступно: <%= hotel.availability_label %></div>
                <div class="flex items-end justify-between">
                  <div>
                    <div class="font-serif text-tx leading-none" style="font-size:clamp(20px,2.2vw,26px)">₽<%= hotel.display_price.to_i %></div>
                    <div class="text-tx3 mt-1" style="font-size:clamp(10px,1vw,12px)">за ночь · базовая цена</div>
                  </div>
                  <button onclick="window.location.href='/hotels/<%= hotel.id %>'" class="rounded-[12px] border-none text-bg font-extrabold cursor-pointer transition-all hover:-translate-y-0.5" style="padding:clamp(9px,1vw,12px) clamp(14px,1.5vw,20px);background:linear-gradient(135deg,#1db896,#15a07f);box-shadow:0 6px 20px rgba(29,184,150,.3);font-size:clamp(11px,1.2vw,14px)">
                    Подробнее
                  </button>
                </div>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    <% end %>
    <div class="px-4 sm:px-6 lg:px-10 py-8 lg:py-12 bg-bg2">
      <div class="flex items-center justify-between mb-4 lg:mb-6">
        <div class="font-bold text-tx" style="font-size:clamp(16px,2vw,22px)">Популярные направления</div>
        <div class="text-tl font-semibold cursor-pointer transition-all hover:opacity-75" style="font-size:clamp(11px,1.2vw,14px)" onclick="doSearch()">Все →</div>
      </div>
      <div class="no-sb flex gap-3 overflow-x-auto pb-2 lg:grid lg:grid-cols-5 lg:overflow-visible lg:gap-4 xl:gap-5" id="dest-scroll">
        <% @popular_cities ||= ['Москва', 'Санкт-Петербург', 'Сочи', 'Казань', 'Калининград'] %>
        <% @popular_cities.each do |city| %>
          <div onclick="document.getElementById('dest').value='<%= city %>';doSearch()"
            style="flex-shrink:0;width:clamp(140px,28vw,200px);border-radius:18px;overflow:hidden;position:relative;cursor:pointer;border:1px solid rgba(29,184,150,.18);transition:transform .25s;aspect-ratio:3/4"
            onmouseover="this.style.transform='scale(1.03)'" onmouseout="this.style.transform=''">
            <img src="https://picsum.photos/seed/<%= city.parameterize %>/300/400" alt="<%= city %>" loading="lazy"
              style="width:100%;height:100%;object-fit:cover;display:block;transition:transform .4s">
            <div style="position:absolute;inset:0;background:linear-gradient(to top,rgba(5,15,12,.92) 0%,rgba(5,15,12,.2) 50%,transparent 100%);display:flex;flex-direction:column;justify-content:flex-end;padding:14px">
              <div style="font-size:clamp(14px,1.6vw,17px);font-weight:700;color:#fff;line-height:1.2"><%= city %></div>
              <div style="font-size:clamp(10px,1.1vw,12px);color:rgba(255,255,255,.6);margin-top:3px">от 2 500 ₽</div>
            </div>
            <div style="position:absolute;top:10px;left:10px;background:rgba(29,184,150,.88);color:#050f0c;font-size:9px;font-weight:800;letter-spacing:.8px;text-transform:uppercase;padding:4px 9px;border-radius:7px;backdrop-filter:blur(6px)">🏨 Топ</div>
          </div>
        <% end %>
      </div>
    </div>
  </div>
</div>
<div class="fixed inset-0 z-[200] hidden" id="mover">
  <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeMenu()"></div>
  <div class="absolute right-0 top-0 bottom-0 w-[290px] sm:w-[340px] bg-bg3 border-l border-white/8 flex flex-col animate-drawerIn">
    <div class="flex items-center justify-between p-5 border-b border-white/8">
      <svg width="100" viewBox="0 0 140 36" fill="none">
        <path d="M28 5 C16 5 6 13 6 22 C6 31 16 36 28 36" stroke="#1db896" stroke-width="5" stroke-linecap="round" fill="none"/>
        <ellipse cx="7" cy="22" rx="5" ry="6" fill="#1db896"/>
        <path d="M7 28 L5 34 L7 31 L9 34 Z" fill="#1db896"/>
        <circle cx="7" cy="21" r="2" fill="#050f0c"/>
        <rect x="6.2" y="22.5" width="1.6" height="3" rx=".8" fill="#050f0c"/>
        <path d="M35 8 L35 32 M35 20 Q40 14 46 20 L46 32" stroke="#1db896" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        <path d="M52 26 Q52 18 59 18 Q66 18 66 24 L52 24 M52 26 Q52 32 59 32" stroke="#1db896" stroke-width="4" stroke-linecap="round" fill="none"/>
        <path d="M82 20 Q75 15 70 23 Q65 31 73 32 Q79 32 82 27" stroke="#1db896" stroke-width="4" stroke-linecap="round" fill="none"/>
        <path d="M96 17 Q88 17 88 24 Q88 32 96 32 Q104 32 104 24 Q104 19 101 17 M102 30 L108 36" stroke="#1db896" stroke-width="4" stroke-linecap="round" fill="none"/>
        <circle cx="113" cy="12" r="2.5" fill="#1db896"/>
        <line x1="113" y1="18" x2="113" y2="32" stroke="#1db896" stroke-width="4" stroke-linecap="round"/>
        <path d="M120 32 L120 18 Q120 18 127 26 Q134 32 134 32 L134 18" stroke="#1db896" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
      </svg>
      <button onclick="closeMenu()" class="w-8 h-8 rounded-[9px] border border-white/10 bg-white/[.04] text-tx2 text-base flex items-center justify-center transition-all hover:border-tl hover:text-tl">✕</button>
    </div>
    <div class="flex-1 overflow-y-auto">
      <% if user_signed_in? %>
        <%= link_to '/',
                    class: "flex items-center justify-between px-5 py-4 border-b border-white/8 cursor-pointer hover:bg-tl/5 transition-colors",
                    data: { turbo: false } do %>
          <div class="flex items-center gap-3.5">
            <div class="w-10 h-10 rounded-xl bg-tl/10 border border-tl/20 flex items-center justify-center text-tl"><svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/></svg></div>
            <span class="text-sm font-semibold text-tx"><%= current_user.email %></span>
          </div>
          <svg class="w-4 h-4 text-tx3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg>
        <% end %>
      <% else %>
        <%= link_to new_user_session_path,
                    class: "flex items-center justify-between px-5 py-4 border-b border-white/8 cursor-pointer hover:bg-tl/5 transition-colors",
                    data: { turbo: false } do %>
          <div class="flex items-center gap-3.5">
            <div class="w-10 h-10 rounded-xl bg-tl/10 border border-tl/20 flex items-center justify-center text-tl"><svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/></svg></div>
            <span class="text-sm font-semibold text-tx">Войти</span>
          </div>
          <svg class="w-4 h-4 text-tx3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg>
        <% end %>
        <%= link_to new_user_registration_path(account_type: :supervisor),
                    class: "flex items-center justify-between px-5 py-4 border-b border-white/8 cursor-pointer hover:bg-tl/5 transition-colors",
                    data: { turbo: false } do %>
          <div class="flex items-center gap-3.5">
            <div class="w-10 h-10 rounded-xl bg-tl/10 border border-tl/20 flex items-center justify-center text-tl"><svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M3 21h18M5 21V7l8-4 6 3v15M9 9h.01M9 13h.01M9 17h.01M15 9h.01M15 13h.01M15 17h.01"/></svg></div>
            <span class="text-sm font-semibold text-tx">Стать супервайзором</span>
          </div>
          <svg class="w-4 h-4 text-tx3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg>
        <% end %>
      <% end %>
      <div class="flex items-center justify-between px-5 py-4 border-b border-white/8 cursor-pointer hover:bg-tl/5 transition-colors">
        <div class="flex items-center gap-3.5">
          <div class="w-10 h-10 rounded-xl bg-tl/10 border border-tl/20 flex items-center justify-center text-tl"><svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg></div>
          <span class="text-sm font-semibold text-tx">Помощь</span>
        </div>
        <svg class="w-4 h-4 text-tx3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg>
      </div>
      <div class="flex items-center justify-between px-5 py-4 border-b border-white/8 cursor-pointer hover:bg-tl/5 transition-colors">
        <div class="flex items-center gap-3.5">
          <div class="w-10 h-10 rounded-xl bg-tl/10 border border-tl/20 flex items-center justify-center text-tl"><svg class="w-[18px] h-[18px]" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg></div>
          <span class="text-sm font-semibold text-tx">Валюта</span>
        </div>
        <div class="flex items-center gap-2"><span class="text-xs text-tx3">RUB ₽</span><svg class="w-4 h-4 text-tx3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg></div>
      </div>
    </div>
    <div class="px-5 py-5 border-t border-white/8 text-center">
      <div class="text-xs font-extrabold text-tl tracking-widest">CHECQIN</div>
      <div class="text-[11px] text-tx3 mt-1">Умные путешествия.</div>
    </div>
  </div>
</div>
<div class="fixed inset-0 z-[300] hidden items-end lg:items-center justify-center" id="cov"
     onclick="if(event.target===this)closeCal()">
  <div class="absolute inset-0 bg-black/70 backdrop-blur-md" onclick="closeCal()"></div>
  <div class="relative w-full lg:w-auto lg:min-w-[420px] max-w-[520px] mx-auto bg-bg3 border border-tl/20 rounded-t-[26px] lg:rounded-[26px] overflow-hidden animate-sheetUp">

    <div class="bg-bg4 px-5 sm:px-6 pt-5 pb-4 border-b border-white/8">
      <div class="w-9 h-1 bg-tx3/40 rounded-full mx-auto mb-4 lg:hidden"></div>
      <div class="font-extrabold tracking-[1.5px] uppercase text-tl mb-2" id="chint" style="font-size:clamp(9px,1vw,11px)">Выберите дату заезда</div>
      <div class="flex items-center justify-between">
        <div class="font-serif text-tx" id="cmnth" style="font-size:clamp(18px,2vw,22px)">Март 2026</div>
        <div class="flex gap-1.5">
          <button id="cprev" onclick="cNav(-1)" class="w-9 h-9 rounded-[10px] border border-tl/20 bg-white/[.04] text-tx2 text-base flex items-center justify-center transition-all hover:border-tl hover:text-tl disabled:opacity-20 disabled:cursor-not-allowed">‹</button>
          <button id="cnext" onclick="cNav(1)"  class="w-9 h-9 rounded-[10px] border border-tl/20 bg-white/[.04] text-tx2 text-base flex items-center justify-center transition-all hover:border-tl hover:text-tl">›</button>
        </div>
      </div>
    </div>

    <div class="px-3.5 sm:px-5 pt-4 pb-2 bg-bg3">
      <div class="grid grid-cols-7 mb-2">
        <div class="text-center text-tx3 font-extrabold tracking-[.8px] uppercase py-1" style="font-size:clamp(8px,.9vw,10px)">Вс</div>
        <div class="text-center text-tx3 font-extrabold tracking-[.8px] uppercase py-1" style="font-size:clamp(8px,.9vw,10px)">Пн</div>
        <div class="text-center text-tx3 font-extrabold tracking-[.8px] uppercase py-1" style="font-size:clamp(8px,.9vw,10px)">Вт</div>
        <div class="text-center text-tx3 font-extrabold tracking-[.8px] uppercase py-1" style="font-size:clamp(8px,.9vw,10px)">Ср</div>
        <div class="text-center text-tx3 font-extrabold tracking-[.8px] uppercase py-1" style="font-size:clamp(8px,.9vw,10px)">Чт</div>
        <div class="text-center text-tx3 font-extrabold tracking-[.8px] uppercase py-1" style="font-size:clamp(8px,.9vw,10px)">Пт</div>
        <div class="text-center text-tx3 font-extrabold tracking-[.8px] uppercase py-1" style="font-size:clamp(8px,.9vw,10px)">Сб</div>
      </div>
      <div class="grid grid-cols-7 gap-0.5" id="cdays"></div>
    </div>

    <div class="flex gap-2.5 px-4 sm:px-5 py-3 border-t border-white/8">
      <div class="flex-1 p-2.5 rounded-[13px] bg-white/[.04] border border-white/8 cursor-pointer transition-all" id="csb-ci" onclick="setCalMode('checkin')">
        <div class="font-extrabold tracking-[1.2px] uppercase text-tx3" style="font-size:clamp(8px,.9vw,10px)">ЗАЕЗД</div>
        <div class="font-bold text-tx mt-1" id="ci-sv" style="font-size:clamp(12px,1.3vw,14px)">—</div>
      </div>
      <div class="flex-1 p-2.5 rounded-[13px] bg-white/[.04] border border-white/8 cursor-pointer transition-all" id="csb-co" onclick="setCalMode('checkout')">
        <div class="font-extrabold tracking-[1.2px] uppercase text-tx3" style="font-size:clamp(8px,.9vw,10px)">ВЫЕЗД</div>
        <div class="font-bold text-tx mt-1" id="co-sv" style="font-size:clamp(12px,1.3vw,14px)">—</div>
      </div>
    </div>

    <div class="flex gap-2.5 px-4 sm:px-5 pb-6 sm:pb-8 pt-3">
      <button onclick="closeCal()" class="flex-1 py-3.5 rounded-2xl border border-white/10 bg-white/[.04] text-tx2 font-semibold cursor-pointer font-sans transition-all hover:border-tl hover:text-tl" style="font-size:clamp(12px,1.3vw,14px)">Отмена</button>
      <button onclick="confirmDates()" class="flex-[2] py-3.5 rounded-2xl border-none text-bg font-extrabold cursor-pointer font-sans" style="background:linear-gradient(135deg,#1db896,#15a07f);box-shadow:0 6px 20px rgba(29,184,150,.35);font-size:clamp(12px,1.3vw,14px)">Подтвердить даты</button>
    </div>
  </div>
</div>

<script>
(function(){
  const c=document.getElementById('aurora'),ctx=c.getContext('2d');
  let W,H,t=0;
  const orbs=[
    {x:.2,y:.3,r:.38,col:'rgba(29,184,150,.18)',sp:.0003},
    {x:.8,y:.1,r:.3,col:'rgba(29,184,150,.12)',sp:.0005},
    {x:.5,y:.75,r:.42,col:'rgba(13,122,96,.13)',sp:.0002},
    {x:.1,y:.9,r:.25,col:'rgba(29,184,150,.1)',sp:.0006},
  ];
  function resize(){W=c.width=window.innerWidth;H=c.height=window.innerHeight}
  resize();window.addEventListener('resize',resize);
  function draw(){
    ctx.clearRect(0,0,W,H);
    orbs.forEach(o=>{
      const ox=W*(o.x+.08*Math.sin(t*o.sp*3));
      const oy=H*(o.y+.06*Math.cos(t*o.sp*2));
      const r=Math.min(W,H)*o.r;
      const g=ctx.createRadialGradient(ox,oy,0,ox,oy,r);
      g.addColorStop(0,o.col);g.addColorStop(1,'rgba(0,0,0,0)');
      ctx.fillStyle=g;ctx.beginPath();ctx.arc(ox,oy,r,0,Math.PI*2);ctx.fill();
    });
    t++;requestAnimationFrame(draw);
  }
  draw();
})();
const S={
  guests:2,
  ci:new Date(2026,2,23),co:new Date(2026,2,24),
  calM:'checkin',calY:2026,calMo:2,
  tCI:null,tCO:null
};

const MN=['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'];
const MS=['янв','фев','мар','апр','май','июн','июл','авг','сен','окт','ноя','дек'];
function adjG(d){
  S.guests=Math.max(1,Math.min(10,S.guests+d));
  document.getElementById('gn').textContent=S.guests;
  document.getElementById('guests_hidden').value=S.guests;
  const f=['гость','гостя','гостей'];
  const v=S.guests,n=v%100>=11&&v%100<=19?2:v%10===1?0:v%10>=2&&v%10<=4?1:2;
  document.getElementById('gv').textContent=v+' '+f[n];
}
function fmtS(d){if(!d)return'—';return d.getDate()+' '+MS[d.getMonth()]+', '+d.getFullYear()}
function fmtSh(d){if(!d)return'—';return d.getDate()+' '+MS[d.getMonth()]}
function doSearch(){
  document.getElementById('checkin_hidden').value = S.ci.toISOString().split('T')[0];
  document.getElementById('checkout_hidden').value = S.co.toISOString().split('T')[0];
  document.getElementById('guests_hidden').value = S.guests;
  document.querySelector('.search-form').submit();
}
function openMenu(){const m=document.getElementById('mover');m.classList.remove('hidden');m.classList.add('flex')}
function closeMenu(){const m=document.getElementById('mover');m.classList.add('hidden');m.classList.remove('flex')}
function openCal(mode){
  S.calM=mode;S.tCI=S.ci?new Date(S.ci):null;S.tCO=S.co?new Date(S.co):null;
  const ref=mode==='checkin'?S.ci:S.co;
  S.calY=ref?ref.getFullYear():2026;S.calMo=ref?ref.getMonth():2;
  refCal();
  const el=document.getElementById('cov');
  el.classList.remove('hidden');el.classList.add('flex');
}
function closeCal(){const el=document.getElementById('cov');el.classList.add('hidden');el.classList.remove('flex')}
function cNav(d){
  S.calMo+=d;
  if(S.calMo>11){S.calMo=0;S.calY++}
  if(S.calMo<0){S.calMo=11;S.calY--}
  if(S.calY<2020){S.calY=2020;S.calMo=0}
  refCal();
}
function setCalMode(m){S.calM=m;refCal()}
function refCal(){
  document.getElementById('cmnth').textContent=MN[S.calMo]+' '+S.calY;
  document.getElementById('cprev').disabled=(S.calY===2020&&S.calMo===0);
  document.getElementById('chint').textContent=S.calM==='checkin'?'Выберите дату заезда':'Выберите дату выезда';
  const ci=document.getElementById('csb-ci'),co=document.getElementById('csb-co');
  ci.style.borderColor=S.calM==='checkin'?'#1db896':'rgba(255,255,255,.08)';
  ci.style.background=S.calM==='checkin'?'rgba(29,184,150,.08)':'rgba(255,255,255,.04)';
  co.style.borderColor=S.calM==='checkout'?'#1db896':'rgba(255,255,255,.08)';
  co.style.background=S.calM==='checkout'?'rgba(29,184,150,.08)':'rgba(255,255,255,.04)';
  document.getElementById('ci-sv').textContent=fmtSh(S.tCI)||'—';
  document.getElementById('co-sv').textContent=fmtSh(S.tCO)||'—';
  renderCalDays();
}
function renderCalDays(){
  const y=S.calY,m=S.calMo;
  const first=new Date(y,m,1).getDay(),days=new Date(y,m+1,0).getDate();
  const today=new Date();today.setHours(0,0,0,0);
  const ci=S.tCI,co=S.tCO;
  let h='';
  for(let i=0;i<first;i++)h+=`<button class="cd emp" disabled></button>`;
  for(let d=1;d<=days;d++){
    const dt=new Date(y,m,d);
    const isCI=ci&&dt.toDateString()===ci.toDateString();
    const isCO=co&&dt.toDateString()===co.toDateString();
    const inR=ci&&co&&dt>ci&&dt<co;
    const isTd=dt.toDateString()===today.toDateString();
    const before=dt<new Date(2020,0,1);
    let cls='cd';
    if(isCI||isCO)cls+=' sel';else if(inR)cls+=' rng';
    if(isTd&&!isCI&&!isCO)cls+=' td';
    if(before)cls+=' dis';
    h+=`<button class="${cls}" onclick="pickDay(${y},${m},${d})">${d}</button>`;
  }
  document.getElementById('cdays').innerHTML=h;
}
function pickDay(y,m,d){
  const dt=new Date(y,m,d);
  if(dt<new Date(2020,0,1))return;
  if(S.calM==='checkin'){
    S.tCI=dt;if(S.tCO&&S.tCO<=dt)S.tCO=null;S.calM='checkout';
  }else{
    if(S.tCI&&dt<=S.tCI){S.tCI=dt;S.tCO=null;S.calM='checkout';}
    else S.tCO=dt;
  }
  refCal();
}
function confirmDates(){
  if(!S.tCI)return;
  S.ci=S.tCI;S.co=S.tCO||new Date(S.tCI.getTime()+86400000);
  document.getElementById('ci-txt').textContent=fmtS(S.ci);
  document.getElementById('co-txt').textContent=fmtS(S.co);
  document.getElementById('checkin_hidden').value = S.ci.toISOString().split('T')[0];
  document.getElementById('checkout_hidden').value = S.co.toISOString().split('T')[0];
  closeCal();
}
document.getElementById('ci-txt').textContent=fmtS(S.ci);
document.getElementById('co-txt').textContent=fmtS(S.co);
document.getElementById('checkin_hidden').value = S.ci.toISOString().split('T')[0];
document.getElementById('checkout_hidden').value = S.co.toISOString().split('T')[0];
document.getElementById('guests_hidden').value = S.guests;
</script>
</body>
</html>
```

---

## `app/views/hotels/new.html.erb`

```
<h1>Hotels#new</h1>
<p>Find me in app/views/hotels/new.html.erb</p>
```

---

## `app/views/hotels/search.html.erb`

```
<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checqin — Поиск отелей</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<script>
tailwind.config = {
  theme: {
    extend: {
      colors: {
        tl:'#1db896',tl2:'#15a07f',tl3:'#0d7a60',
        bg:'#050f0c',bg2:'#091410',bg3:'#0d1c18',bg4:'#122720',
        tx:'#e8f5f1',tx2:'#9bbdb5',tx3:'#5a8078',
      },
      fontFamily: {
        serif:['"DM Serif Display"','serif'],
        sans:['"Plus Jakarta Sans"','sans-serif'],
      },
    }
  }
}
</script>
<style>
*,*::before,*::after{box-sizing:border-box}
body{font-family:'Plus Jakarta Sans',sans-serif;margin:0}
#aurora{position:fixed;inset:0;z-index:0;pointer-events:none;opacity:.5}
.glass-hdr{background:rgba(5,15,12,.82);backdrop-filter:blur(20px);border-bottom:1px solid rgba(29,184,150,.15)}
.ft{flex-shrink:0;padding:8px 18px;border-radius:20px;border:1px solid rgba(255,255,255,.1);background:rgba(255,255,255,.04);font-size:clamp(11px,1.3vw,13px);font-weight:600;color:#9bbdb5;cursor:pointer;white-space:nowrap;transition:all .2s}
.ft.on{background:#1db896;border-color:#1db896;color:#050f0c}
.hcard-wrap:hover .hcard-photo{transform:scale(1.05)}
.hcard-photo{transition:transform .4s;width:100%;height:100%;object-fit:cover;display:block}
@media(min-width:1280px){.hotels-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:20px}}
@media(min-width:768px) and (max-width:1023px){.hotels-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:16px}}
@media(max-width:767px){.hotels-grid{display:flex;flex-direction:column;gap:16px}}
</style>
</head>
<body class="bg-bg min-h-screen text-tx overflow-x-hidden">
<canvas id="aurora"></canvas>

<div class="relative z-10 flex flex-col min-h-screen">
  <header class="glass-hdr sticky top-0 z-50 flex items-center justify-between px-4 sm:px-6 lg:px-8 py-3 lg:py-4">
    <div class="flex items-center gap-2 cursor-pointer flex-shrink-0" onclick="window.location.href='/'">
      <svg width="110" height="30" viewBox="0 0 240 60" fill="none">
        <path d="M44 10 C24 10 8 21 8 35 C8 49 24 56 44 56" stroke="#1db896" stroke-width="7" stroke-linecap="round" fill="none"/>
        <ellipse cx="9" cy="35" rx="7" ry="9" fill="#1db896"/>
        <path d="M9 44 L6 53 L9 49 L12 53 Z" fill="#1db896"/>
        <circle cx="9" cy="33" r="3" fill="#050f0c"/>
        <rect x="8" y="35.5" width="2" height="4" rx="1" fill="#050f0c"/>
        <path d="M56 12 L56 48 M56 30 Q63 21 73 30 L73 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        <path d="M82 36 Q82 24 93 24 Q103 24 103 33 L82 33 M82 36 Q82 48 93 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/>
        <path d="M130 28 Q120 20 111 33 Q102 46 114 47 Q122 47 130 40" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/>
        <path d="M150 24 Q137 24 137 35 Q137 47 150 47 Q163 47 163 35 Q163 28 158 25 M161 44 L170 54" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/>
        <circle cx="178" cy="18" r="4" fill="#1db896"/>
        <line x1="178" y1="27" x2="178" y2="48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round"/>
        <path d="M188 48 L188 27 Q188 27 198 38 Q208 48 208 48 L208 27" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
      </svg>
    </div>
    <nav class="hidden lg:flex items-center gap-6 text-sm font-semibold text-tx2">
      <span class="hover:text-tl cursor-pointer transition-colors" onclick="window.location.href='/'">Главная</span>
      <span class="hover:text-tl cursor-pointer transition-colors" onclick="window.location.href='/search'">Все отели</span>
      <span class="hover:text-tl cursor-pointer transition-colors" onclick="window.location.href='/favorites'">Избранное</span>
      <% if user_signed_in? %>
        <% if current_user.supervisor? %>
          <span class="hover:text-tl cursor-pointer transition-colors" onclick="window.location.href='/supervisor'">Супервайзор</span>
        <% end %>
        <%= button_to "Выйти",
                      destroy_user_session_path,
                      method: :delete,
                      class: "hover:text-tl cursor-pointer transition-colors bg-transparent border-none p-0 font-semibold text-sm",
                      form: { data: { turbo: false } } %>
      <% else %>
        <%= link_to "Войти",
                    new_user_session_path,
                    class: "hover:text-tl cursor-pointer transition-colors text-sm font-semibold text-tx2",
                    data: { turbo: false } %>
      <% end %>
    </nav>
    <div class="flex items-center gap-2">
      <button onclick="window.location.href='/favorites'" title="Избранное" class="w-9 h-9 lg:w-10 lg:h-10 rounded-xl border border-white/10 bg-white/[.04] flex items-center justify-center text-tx2 cursor-pointer transition-all hover:border-tl hover:text-tl hover:bg-tl/10">
        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/></svg>
      </button>
    </div>
  </header>
  <div class="glass-hdr sticky top-0 z-10 flex items-center gap-3 px-4 sm:px-6 lg:px-8 py-3 lg:py-4">
    <button onclick="window.location.href='/'"
      class="w-9 h-9 rounded-[11px] border border-white/10 bg-white/[.04] text-tx2 flex items-center justify-center flex-shrink-0 transition-all hover:border-tl hover:text-tl">
      <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/></svg>
    </button>
    <div class="flex-1 min-w-0">
      <div class="font-bold text-tx truncate" id="res-city" style="font-size:clamp(14px,1.6vw,18px)"><%= @city || 'Все отели' %></div>
      <div class="text-tx3 mt-0.5" id="res-info" style="font-size:clamp(10px,1.1vw,12px)">
        <%= @checkin ? @checkin : '' %> — <%= @checkout ? @checkout : '' %> · <%= @guests %> гост.
      </div>
    </div>
    <div class="hidden lg:flex gap-2">
      <button class="ft on" data-f="all" onclick="setFlt(this,'all')">Все</button>
      <button class="ft" data-f="hotels" onclick="setFlt(this,'hotels')">Отели</button>
      <button class="ft" data-f="suites" onclick="setFlt(this,'suites')">Апартаменты</button>
    </div>
  </div>
  <div class="lg:hidden no-sb flex gap-2 px-4 py-3 overflow-x-auto bg-bg2">
    <button class="ft on" data-f="all" onclick="setFlt(this,'all')">Все</button>
    <button class="ft" data-f="hotels" onclick="setFlt(this,'hotels')">Отели</button>
    <button class="ft" data-f="suites" onclick="setFlt(this,'suites')">Апартаменты</button>
  </div>
  <div class="px-4 sm:px-6 lg:px-8 xl:px-10 pt-4 pb-10 hotels-grid" id="hotels-list">
    <% if @hotels.any? %>
      <% @hotels.each do |hotel| %>
        <div class="hcard-wrap rounded-[20px] overflow-hidden bg-bg3 border border-white/8 transition-all duration-300 hover:-translate-y-1" style="box-shadow:0 2px 14px rgba(0,0,0,.22)">
          <div style="position:relative;height:185px;overflow:hidden;background:#122720">
            <% if hotel.photos.attached? && hotel.photos.first.present? %>
              <img class="hcard-photo" src="<%= url_for(hotel.photos.first) %>" alt="<%= hotel.name %>" loading="lazy"
                style="width:100%;height:100%;object-fit:cover;display:block">
            <% else %>
              <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;font-size:52px;background:linear-gradient(135deg,#122720,#0d1c18)">🏨</div>
            <% end %>
            <% if hotel.description.present? %>
              <div style="position:absolute;top:12px;left:12px;background:rgba(29,184,150,.9);color:#050f0c;font-size:clamp(9px,1vw,11px);font-weight:800;padding:4px 10px;border-radius:8px;backdrop-filter:blur(6px)">⭐ Топ</div>
            <% end %>
            <button id="hf-<%= hotel.id %>" onclick="toggleFav(<%= hotel.id %>)"
              style="position:absolute;top:12px;right:12px;width:34px;height:34px;border-radius:50%;border:none;background:rgba(5,15,12,.75);backdrop-filter:blur(8px);cursor:pointer;display:flex;align-items:center;justify-content:center;transition:all .2s">
              <svg style="width:16px;height:16px" fill="none" viewBox="0 0 24 24" stroke="#9bbdb5" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/></svg>
            </button>
          </div>
          <div class="p-4 sm:p-5">
            <div class="flex items-center justify-between mb-2">
              <div style="color:#f5c842;font-size:clamp(10px,1.1vw,13px);letter-spacing:1px"><%= "★" * hotel.rating.to_i %><%= "☆" * (5 - hotel.rating.to_i) %></div>
              <div style="background:#1db896;color:#050f0c;font-weight:800;font-size:clamp(11px,1.1vw,13px);padding:4px 9px;border-radius:8px"><%= hotel.rating || 4.5 %></div>
            </div>
            <div class="font-bold text-tx mb-1 leading-snug" style="font-size:clamp(13px,1.4vw,16px)"><%= link_to hotel.name, hotel_path(hotel), style: "color: #e8f5f1; text-decoration: none;" %></div>
            <div class="flex items-center gap-1.5 text-tx3 mb-3.5" style="font-size:clamp(11px,1.1vw,13px)">
              <svg style="width:11px;height:11px;color:#1db896;flex-shrink:0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
              <%= hotel.city %>, <%= hotel.address %>
            </div>
            <div class="text-tx3 mb-3.5" style="font-size:clamp(10px,1vw,12px)">Доступно: <%= hotel.availability_label %></div>
            <div class="flex items-end justify-between">
              <div>
                <div class="font-serif text-tx leading-none" style="font-size:clamp(20px,2.2vw,26px)">₽<%= hotel.display_price.to_i %></div>
                <div class="text-tx3 mt-1" style="font-size:clamp(10px,1vw,12px)">за ночь · от 1 гостя</div>
              </div>
              <button onclick="window.location.href='/hotels/<%= hotel.id %>'"
                class="rounded-[12px] border-none text-bg font-extrabold cursor-pointer transition-all hover:-translate-y-0.5"
                style="padding:clamp(9px,1vw,12px) clamp(14px,1.5vw,20px);background:linear-gradient(135deg,#1db896,#15a07f);box-shadow:0 6px 20px rgba(29,184,150,.3);font-size:clamp(11px,1.2vw,14px)">
                Подробнее
              </button>
            </div>
          </div>
        </div>
      <% end %>
    <% else %>
      <div class="glass rounded-[24px] p-10 text-center">
        <div class="text-4xl mb-4">🔍</div>
        <p class="text-tx2">По вашему запросу ничего не найдено</p>
      </div>
    <% end %>
  </div>
</div>

<script>
(function(){
  const c=document.getElementById('aurora'),ctx=c.getContext('2d');
  let W,H,t=0;
  const orbs=[
    {x:.2,y:.3,r:.38,col:'rgba(29,184,150,.18)',sp:.0003},
    {x:.8,y:.1,r:.3,col:'rgba(29,184,150,.12)',sp:.0005},
    {x:.5,y:.75,r:.42,col:'rgba(13,122,96,.13)',sp:.0002},
    {x:.1,y:.9,r:.25,col:'rgba(29,184,150,.1)',sp:.0006},
  ];
  function resize(){W=c.width=window.innerWidth;H=c.height=window.innerHeight}
  resize();window.addEventListener('resize',resize);
  function draw(){
    ctx.clearRect(0,0,W,H);
    orbs.forEach(o=>{
      const ox=W*(o.x+.08*Math.sin(t*o.sp*3));
      const oy=H*(o.y+.06*Math.cos(t*o.sp*2));
      const r=Math.min(W,H)*o.r;
      const g=ctx.createRadialGradient(ox,oy,0,ox,oy,r);
      g.addColorStop(0,o.col);g.addColorStop(1,'rgba(0,0,0,0)');
      ctx.fillStyle=g;ctx.beginPath();ctx.arc(ox,oy,r,0,Math.PI*2);ctx.fill();
    });
    t++;requestAnimationFrame(draw);
  }
  draw();
})();
function setFlt(btn,f){
  document.querySelectorAll('.ft').forEach(b=>b.classList.remove('on'));
  document.querySelectorAll('.ft[data-f="'+f+'"]').forEach(b=>b.classList.add('on'));
}
function toggleFav(id){
  fetch('/favorites/toggle/' + id, {
    method: 'POST',
    headers: {
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      'Content-Type': 'application/json'
    }
  }).then(() => {
    location.reload();
  });
}
function applyHotelsGrid(){
  const w=window.innerWidth;
  const el=document.getElementById('hotels-list');
  if(!el)return;
  if(w>=1280){el.style.display='grid';el.style.gridTemplateColumns='repeat(3,1fr)';el.style.gap='20px';el.style.flexDirection=''}
  else if(w>=768){el.style.display='grid';el.style.gridTemplateColumns='repeat(2,1fr)';el.style.gap='16px';el.style.flexDirection=''}
  else{el.style.display='flex';el.style.flexDirection='column';el.style.gap='16px';}
}
window.addEventListener('resize',applyHotelsGrid);
applyHotelsGrid();
</script>
</body>
</html>
```

---

## `app/views/hotels/show.html.erb`

```
<h1>Hotels#show</h1>
<p>Find me in app/views/hotels/show.html.erb</p>
```

---

## `app/views/hotels/update.html.erb`

```
<h1>Hotels#update</h1>
<p>Find me in app/views/hotels/update.html.erb</p>
```

---

## `app/views/layouts/application.html.erb`

```
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Checqin — Умные путешествия</title>
  <meta name="csrf-token" content="<%= form_authenticity_token %>">
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
  <%= javascript_importmap_tags %>
</head>
<body>
  <%= yield %>
</body>
</html>
```

---

## `app/views/layouts/auth.html.erb`

```
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Checqin — Вход и регистрация</title>
  <meta name="csrf-token" content="<%= form_authenticity_token %>">
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            tl: '#1db896',
            tl2: '#15a07f',
            tl3: '#0d7a60',
            bg: '#050f0c',
            bg2: '#091410',
            bg3: '#0d1c18',
            bg4: '#122720',
            tx: '#e8f5f1',
            tx2: '#9bbdb5',
            tx3: '#5a8078'
          },
          fontFamily: {
            serif: ['"DM Serif Display"', 'serif'],
            sans: ['"Plus Jakarta Sans"', 'sans-serif']
          },
          keyframes: {
            pulse2: { '0%,100%': { opacity: '1', transform: 'scale(1)' }, '50%': { opacity: '.4', transform: 'scale(.7)' } },
            fadeUp: { from: { opacity: '0', transform: 'translateY(16px)' }, to: { opacity: '1', transform: 'translateY(0)' } },
            shake: { '0%,100%': { transform: 'translateX(0)' }, '20%': { transform: 'translateX(-6px)' }, '40%': { transform: 'translateX(6px)' }, '60%': { transform: 'translateX(-4px)' }, '80%': { transform: 'translateX(4px)' } }
          },
          animation: {
            pulse2: 'pulse2 2s ease-in-out infinite',
            fadeUp: 'fadeUp .4s ease',
            shake: 'shake .4s ease'
          }
        }
      }
    };
  </script>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
  <%= javascript_importmap_tags %>

  <style>
    *{box-sizing:border-box;margin:0;padding:0}
    body{font-family:'Plus Jakarta Sans',sans-serif}

    #aurora{position:fixed;inset:0;z-index:0;pointer-events:none;opacity:.5}

    .glass{background:rgba(13,28,24,.9);backdrop-filter:blur(22px);-webkit-backdrop-filter:blur(22px);border:1px solid rgba(29,184,150,.18)}
    .glass-hdr{background:rgba(5,15,12,.84);backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);border-bottom:1px solid rgba(29,184,150,.14)}

    .f-inp{
      width:100%;
      padding:14px 44px 14px 16px;
      border:1.5px solid rgba(255,255,255,.1);
      border-radius:14px;
      background:rgba(255,255,255,.05);
      color:#e8f5f1;
      font-family:'Plus Jakarta Sans',sans-serif;
      font-size:14px;
      font-weight:500;
      outline:none;
      transition:all .25s;
    }
    .f-inp:focus{
      border-color:#1db896;
      background:rgba(29,184,150,.06);
      box-shadow:0 0 0 3px rgba(29,184,150,.14);
    }
    .f-inp::placeholder{color:#5a8078;font-weight:400}
    .f-inp.err{border-color:#f24f6b!important;background:rgba(242,79,107,.05)!important;box-shadow:0 0 0 3px rgba(242,79,107,.12)!important}
    .f-inp.ok{border-color:#1db896}

    .cb-box{
      flex-shrink:0;
      width:20px;
      height:20px;
      border-radius:6px;
      border:1.5px solid rgba(255,255,255,.15);
      background:rgba(255,255,255,.05);
      display:flex;
      align-items:center;
      justify-content:center;
      transition:all .2s;
      margin-top:1px;
      cursor:pointer;
    }
    .cb-box.checked{background:#1db896;border-color:#1db896}
    .cb-box.on{background:#1db896;border-color:#1db896}

    .no-sb::-webkit-scrollbar{display:none}
  </style>
</head>
<body>
  <%= yield %>
</body>
</html>
```

---

## `app/views/layouts/mailer.html.erb`

```
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
      /* Email styles need to be inline */
    </style>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```

---

## `app/views/layouts/mailer.text.erb`

```
<%= yield %>
```

---

## `app/views/layouts/supervisor.html.erb`

```
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Checqin — Супервайзор</title>
  <meta name="csrf-token" content="<%= form_authenticity_token %>">
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
  <%= javascript_importmap_tags %>
</head>
<body>
  <%= yield %>
</body>
</html>
```

---

## `app/views/rooms/create.html.erb`

```
<h1>Rooms#create</h1>
<p>Find me in app/views/rooms/create.html.erb</p>
```

---

## `app/views/rooms/destroy.html.erb`

```
<h1>Rooms#destroy</h1>
<p>Find me in app/views/rooms/destroy.html.erb</p>
```

---

## `app/views/rooms/edit.html.erb`

```
<h1>Rooms#edit</h1>
<p>Find me in app/views/rooms/edit.html.erb</p>
```

---

## `app/views/rooms/index.html.erb`

```
<h1>Rooms#index</h1>
<p>Find me in app/views/rooms/index.html.erb</p>
```

---

## `app/views/rooms/new.html.erb`

```
<h1>Rooms#new</h1>
<p>Find me in app/views/rooms/new.html.erb</p>
```

---

## `app/views/rooms/show.html.erb`

```
<h1>Rooms#show</h1>
<p>Find me in app/views/rooms/show.html.erb</p>
```

---

## `app/views/rooms/update.html.erb`

```
<h1>Rooms#update</h1>
<p>Find me in app/views/rooms/update.html.erb</p>
```

---

## `app/views/supervisor/dashboard/choice.html.erb`

```
<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checqin — Супервайзор</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<script>
tailwind.config={theme:{extend:{
  colors:{tl:'#1db896',tl2:'#15a07f',bg:'#050f0c',bg2:'#091410',bg3:'#0d1c18',bg4:'#122720',tx:'#e8f5f1',tx2:'#9bbdb5',tx3:'#5a8078'},
  fontFamily:{serif:['"DM Serif Display"','serif'],sans:['"Plus Jakarta Sans"','sans-serif']},
  keyframes:{fadeUp:{from:{opacity:'0',transform:'translateY(16px)'},to:{opacity:'1',transform:'translateY(0)'}},pulse2:{'0%,100%':{opacity:'1',transform:'scale(1)'},'50%':{opacity:'.4',transform:'scale(.7)'}}},
  animation:{fadeUp:'fadeUp .38s ease',pulse2:'pulse2 2s ease-in-out infinite'},
}}}
</script>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:'Plus Jakarta Sans',sans-serif}
#aurora{position:fixed;inset:0;z-index:0;pointer-events:none;opacity:.42}
.glass{background:rgba(13,28,24,.88);backdrop-filter:blur(22px);border:1px solid rgba(29,184,150,.18)}
.glass-hdr{background:rgba(5,15,12,.86);backdrop-filter:blur(20px);border-bottom:1px solid rgba(29,184,150,.14)}
.choice-card{flex:1;position:relative;border:2px solid rgba(255,255,255,.12);border-radius:20px;background:rgba(255,255,255,.04);cursor:pointer;transition:all .25s;overflow:hidden;display:flex;flex-direction:row;align-items:stretch;min-height:140px}
.choice-card.sel{border-color:#1db896;background:rgba(29,184,150,.07);box-shadow:0 0 0 3px rgba(29,184,150,.14)}
.choice-card:hover:not(.sel){border-color:rgba(29,184,150,.35);background:rgba(29,184,150,.04)}
</style>
</head>
<body class="bg-bg text-tx">
<canvas id="aurora"></canvas>

<div class="relative z-10 flex flex-col min-h-screen">
  <header class="glass-hdr sticky top-0 z-50 flex items-center justify-between px-4 sm:px-6 lg:px-10 py-3.5">
    <a href="<%= supervisor_root_path %>" class="flex items-center gap-2 text-tx2 hover:text-tl transition-colors text-sm font-semibold"><svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/></svg>Мои объекты</a>
    <div class="flex items-center gap-2">
      <div class="flex items-center gap-2.5 bg-white/[.04] border border-white/10 rounded-full pl-1 pr-3 py-1"><div class="w-7 h-7 rounded-full bg-tl/20 border border-tl/30 flex items-center justify-center text-tl text-xs font-bold"><%= current_user.email[0].upcase %></div><span class="text-sm font-semibold text-tx2 hidden sm:block"><%= current_user.email.split('@').first %></span></div>
      <%= button_to "Выйти", destroy_user_session_path, method: :delete, class: "px-4 py-2 rounded-[12px] border border-white/10 bg-white/[.04] text-tx2 font-semibold text-sm cursor-pointer transition-all hover:border-tl hover:text-tl", form: { data: { turbo: false } } %>
    </div>
  </header>
  <main class="flex-1 px-4 sm:px-6 lg:px-14 py-10 lg:py-16 max-w-[1000px] mx-auto w-full">
    <div class="mb-10">
      <h1 class="font-serif text-tx mb-2" style="font-size:clamp(28px,4vw,48px)">Добро пожаловать в Супервайзор</h1>
      <p class="text-tx2" style="font-size:clamp(15px,1.6vw,18px)">Какой у вас объект?</p>
    </div>
    <div class="flex flex-col sm:flex-row gap-4 mb-8">
      <div class="choice-card" id="c-hotels" onclick="selChoice('hotels')">
        <div class="flex-1 p-6 flex flex-col justify-center">
          <div class="flex items-center gap-3 mb-3">
            <div class="w-6 h-6 rounded-full border-2 flex items-center justify-center flex-shrink-0 transition-all" id="r-hotels" style="border-color:rgba(255,255,255,.2)"></div>
            <span class="text-base font-bold text-tx">Объект с номерами</span>
          </div>
          <p class="text-sm text-tx2 leading-relaxed pl-9">Отель, база отдыха, апарт-отели и другие объекты размещения с номерным фондом</p>
        </div>
        <div class="w-[130px] sm:w-[150px] flex-shrink-0 relative overflow-hidden rounded-r-[18px]">
          <img src="https://picsum.photos/seed/hotel22/300/280" alt="Отель" class="w-full h-full object-cover" onerror="this.parentElement.innerHTML='<div style=width:100%;height:100%;background:linear-gradient(135deg,#122720,#0d1c18);display:flex;align-items:center;justify-content:center;font-size:48px>🏨</div>'">
        </div>
      </div>
      <div class="choice-card" id="c-rooms" onclick="selChoice('rooms')">
        <div class="flex-1 p-6 flex flex-col justify-center">
          <div class="flex items-center gap-3 mb-3">
            <div class="w-6 h-6 rounded-full border-2 flex items-center justify-center flex-shrink-0 transition-all" id="r-rooms" style="border-color:rgba(255,255,255,.2)"></div>
            <span class="text-base font-bold text-tx">Жильё целиком</span>
          </div>
          <p class="text-sm text-tx2 leading-relaxed pl-9">Квартира, апартаменты, дом и другое жильё, которое можно забронировать целиком</p>
        </div>
        <div class="w-[130px] sm:w-[150px] flex-shrink-0 relative overflow-hidden rounded-r-[18px]">
          <img src="https://picsum.photos/seed/apt33/300/280" alt="Жильё" class="w-full h-full object-cover" onerror="this.parentElement.innerHTML='<div style=width:100%;height:100%;background:linear-gradient(135deg,#122720,#0d1c18);display:flex;align-items:center;justify-content:center;font-size:48px>🏠</div>'">
        </div>
      </div>
    </div>
    <div id="ch-err" class="hidden mb-4 text-sm font-medium" style="color:#f87171">Выберите тип объекта, чтобы продолжить</div>
    <button onclick="goToForm()" class="flex items-center gap-2.5 px-8 py-4 rounded-[16px] border-none text-bg font-extrabold text-sm cursor-pointer transition-all" style="background:linear-gradient(135deg,#1db896,#15a07f);box-shadow:0 8px 28px rgba(29,184,150,.35)" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform=''">Далее <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/></svg></button>
  </main>
</div>

<script>
(function(){
  const c=document.getElementById('aurora'),ctx=c.getContext('2d');let W,H,t=0;
  const orbs=[{x:.15,y:.25,r:.4,col:'rgba(29,184,150,.14)',sp:.0003},{x:.85,y:.2,r:.35,col:'rgba(29,184,150,.1)',sp:.0005},{x:.4,y:.8,r:.38,col:'rgba(13,122,96,.11)',sp:.0002},{x:.9,y:.65,r:.3,col:'rgba(29,184,150,.09)',sp:.0006}];
  function resize(){W=c.width=window.innerWidth;H=c.height=window.innerHeight}resize();window.addEventListener('resize',resize);
  function draw(){ctx.clearRect(0,0,W,H);orbs.forEach(o=>{const ox=W*(o.x+.07*Math.sin(t*o.sp*3)),oy=H*(o.y+.05*Math.cos(t*o.sp*2)),r=Math.min(W,H)*o.r,g=ctx.createRadialGradient(ox,oy,0,ox,oy,r);g.addColorStop(0,o.col);g.addColorStop(1,'rgba(0,0,0,0)');ctx.fillStyle=g;ctx.beginPath();ctx.arc(ox,oy,r,0,Math.PI*2);ctx.fill()});t++;requestAnimationFrame(draw)}draw();})();

let choice = null;

function selChoice(t){
  choice = t;
  document.getElementById('c-hotels').classList.toggle('sel', t === 'hotels');
  document.getElementById('c-rooms').classList.toggle('sel', t === 'rooms');
  const rh = document.getElementById('r-hotels'), rr = document.getElementById('r-rooms');
  if(t === 'hotels'){
    rh.style.cssText = 'border-color:#1db896;background:#1db896';
    rh.innerHTML = '<div style="width:8px;height:8px;border-radius:50%;background:#050f0c"></div>';
    rr.style.cssText = 'border-color:rgba(255,255,255,.2)';
    rr.innerHTML = '';
  } else {
    rr.style.cssText = 'border-color:#1db896;background:#1db896';
    rr.innerHTML = '<div style="width:8px;height:8px;border-radius:50%;background:#050f0c"></div>';
    rh.style.cssText = 'border-color:rgba(255,255,255,.2)';
    rh.innerHTML = '';
  }
  document.getElementById('ch-err').classList.add('hidden');
}

function goToForm(){
  if(!choice){
    document.getElementById('ch-err').classList.remove('hidden');
    return;
  }
  window.location.href = choice === 'hotels' ? '<%= supervisor_new_hotel_path %>' : '<%= supervisor_new_property_path %>';
}
</script>
</body>
</html>
```

---

## `app/views/supervisor/dashboard/index.html.erb`

```
<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checqin — Супервайзор</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<script>
tailwind.config={theme:{extend:{
  colors:{tl:'#1db896',tl2:'#15a07f',bg:'#050f0c',bg2:'#091410',bg3:'#0d1c18',bg4:'#122720',tx:'#e8f5f1',tx2:'#9bbdb5',tx3:'#5a8078'},
  fontFamily:{serif:['"DM Serif Display"','serif'],sans:['"Plus Jakarta Sans"','sans-serif']},
  keyframes:{
    fadeUp:{from:{opacity:'0',transform:'translateY(16px)'},to:{opacity:'1',transform:'translateY(0)'}},
    pulse2:{'0%,100%':{opacity:'1',transform:'scale(1)'},'50%':{opacity:'.4',transform:'scale(.7)'}},
  },
  animation:{fadeUp:'fadeUp .38s ease',pulse2:'pulse2 2s ease-in-out infinite'},
}}}
</script>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:'Plus Jakarta Sans',sans-serif}
#aurora{position:fixed;inset:0;z-index:0;pointer-events:none;opacity:.42}
.glass{background:rgba(13,28,24,.88);backdrop-filter:blur(22px);-webkit-backdrop-filter:blur(22px);border:1px solid rgba(29,184,150,.18)}
.glass-hdr{background:rgba(5,15,12,.86);backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);border-bottom:1px solid rgba(29,184,150,.14)}
.search-inp{width:100%;padding:12px 44px 12px 16px;border:1.5px solid rgba(255,255,255,.1);border-radius:14px;background:rgba(255,255,255,.05);color:#e8f5f1;font-family:'Plus Jakarta Sans',sans-serif;font-size:13px;outline:none;transition:all .2s}
.search-inp:focus{border-color:#1db896;background:rgba(29,184,150,.06);box-shadow:0 0 0 3px rgba(29,184,150,.13)}
.search-inp::placeholder{color:#5a8078}
.prop-card{background:rgba(13,28,24,.7);border:1px solid rgba(255,255,255,.08);border-radius:20px;overflow:hidden;transition:all .25s}
.prop-card:hover{border-color:rgba(29,184,150,.3);transform:translateY(-3px);box-shadow:0 16px 50px rgba(0,0,0,.35)}
</style>
</head>
<body class="bg-bg text-tx">
<canvas id="aurora"></canvas>

<div class="relative z-10 flex flex-col min-h-screen">
  <header class="glass-hdr sticky top-0 z-50 flex items-center justify-between px-4 sm:px-6 lg:px-10 py-3.5">
    <div><svg width="108" height="29" viewBox="0 0 240 60" fill="none"><path d="M44 10 C24 10 8 21 8 35 C8 49 24 56 44 56" stroke="#1db896" stroke-width="7" stroke-linecap="round" fill="none"/><ellipse cx="9" cy="35" rx="7" ry="9" fill="#1db896"/><path d="M9 44 L6 53 L9 49 L12 53 Z" fill="#1db896"/><circle cx="9" cy="33" r="3" fill="#050f0c"/><rect x="8" y="35.5" width="2" height="4" rx="1" fill="#050f0c"/><path d="M56 12 L56 48 M56 30 Q63 21 73 30 L73 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/><path d="M82 36 Q82 24 93 24 Q103 24 103 33 L82 33 M82 36 Q82 48 93 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/><path d="M130 28 Q120 20 111 33 Q102 46 114 47 Q122 47 130 40" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/><path d="M150 24 Q137 24 137 35 Q137 47 150 47 Q163 47 163 35 Q163 28 158 25 M161 44 L170 54" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/><circle cx="178" cy="18" r="4" fill="#1db896"/><line x1="178" y1="27" x2="178" y2="48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round"/><path d="M188 48 L188 27 Q188 27 198 38 Q208 48 208 48 L208 27" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/></svg></div>
    <nav class="hidden lg:flex items-center gap-6 text-sm font-semibold text-tx2"><span class="text-tl">Мои объекты</span><span class="hover:text-tl cursor-pointer transition-colors">Бронирования</span><span class="hover:text-tl cursor-pointer transition-colors">Аналитика</span></nav>
    <div class="flex items-center gap-2">
      <div class="flex items-center gap-2.5 bg-white/[.04] border border-white/10 rounded-full pl-1 pr-3 py-1"><div class="w-7 h-7 rounded-full bg-tl/20 border border-tl/30 flex items-center justify-center text-tl text-xs font-bold"><%= current_user.email[0].upcase %></div><span class="text-sm font-semibold text-tx2 hidden sm:block"><%= current_user.email.split('@').first %></span></div>
      <%= button_to "Выйти", destroy_user_session_path, method: :delete, class: "px-4 py-2 rounded-[12px] border border-white/10 bg-white/[.04] text-tx2 font-semibold text-sm cursor-pointer transition-all hover:border-tl hover:text-tl", form: { data: { turbo: false } } %>
    </div>
  </header>
  <main class="flex-1 px-4 sm:px-6 lg:px-10 py-8 max-w-[1200px] mx-auto w-full">
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-6">
      <div>
        <div class="inline-flex items-center gap-2 bg-tl/10 border border-tl/25 text-tl text-[10px] font-bold tracking-[1.4px] uppercase px-3 py-1.5 rounded-full mb-2.5"><span class="w-1.5 h-1.5 bg-tl rounded-full animate-pulse2"></span>Супервайзор</div>
        <h1 class="font-serif text-tx" style="font-size:clamp(22px,3vw,34px)">Мои объекты</h1>
      </div>
      <div class="flex items-center gap-3 flex-1 sm:flex-none sm:min-w-[420px] justify-end">
        <div class="relative flex-1 sm:flex-none sm:w-[260px]">
          <input id="search-inp" type="text" placeholder="Поиск по названию…" class="search-inp" oninput="filterProps()">
          <div class="absolute right-3.5 top-1/2 -translate-y-1/2 text-tx3 pointer-events-none"><svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg></div>
        </div>
        <a href="<%= supervisor_choice_path %>" class="flex items-center gap-2 px-4 py-3 rounded-[14px] border-none text-bg font-extrabold text-sm cursor-pointer flex-shrink-0 transition-all" style="background:linear-gradient(135deg,#1db896,#15a07f);box-shadow:0 6px 20px rgba(29,184,150,.35)" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform=''">
          <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>Добавить объект
        </a>
      </div>
    </div>
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-3 mb-7">
      <div class="glass rounded-[16px] p-4"><div class="text-[9px] font-extrabold tracking-[1.5px] uppercase text-tx3 mb-1">Объектов</div><div class="font-serif text-tx" id="s-total" style="font-size:clamp(26px,2.5vw,32px)"><%= @objects.count %></div></div>
      <div class="glass rounded-[16px] p-4"><div class="text-[9px] font-extrabold tracking-[1.5px] uppercase text-tx3 mb-1">Активных</div><div class="font-serif text-tl" id="s-active" style="font-size:clamp(26px,2.5vw,32px)"><%= @objects.count(&:active?) %></div></div>
      <div class="glass rounded-[16px] p-4"><div class="text-[9px] font-extrabold tracking-[1.5px] uppercase text-tx3 mb-1">На проверке</div><div class="font-serif text-tx" id="s-review" style="font-size:clamp(26px,2.5vw,32px)"><%= @objects.count(&:review?) %></div></div>
      <div class="glass rounded-[16px] p-4"><div class="text-[9px] font-extrabold tracking-[1.5px] uppercase text-tx3 mb-1">Отели / Жильё</div><div class="font-serif text-tx" id="s-types" style="font-size:clamp(26px,2.5vw,32px)"><%= @hotels.count %>/<%= @properties.count %></div></div>
    </div>
    <div id="props-grid" class="grid sm:grid-cols-2 xl:grid-cols-3 gap-4">
      <% if @objects.any? %>
        <% (@hotels + @properties).each do |obj| %>
          <div class="prop-card">
            <div style="height:150px;background:linear-gradient(135deg,#122720,#0d1c18);display:flex;align-items:center;justify-content:center;font-size:52px;position:relative">
              <%= obj.is_a?(Hotel) ? '🏨' : '🏠' %>
              <% badge_text = obj.active? ? 'Активен' : (obj.rejected? ? 'Отклонён' : 'На проверке') %>
              <% badge_style = obj.active? ? 'background:rgba(29,184,150,.15);color:#1db896' : (obj.rejected? ? 'background:rgba(242,79,107,.15);color:#f87171' : 'background:rgba(245,200,66,.15);color:#f5c842') %>
              <div style="position:absolute;top:10px;left:10px;padding:3px 10px;border-radius:20px;font-size:10px;font-weight:700;<%= badge_style %>"><%= badge_text %></div>
              <div style="position:absolute;top:10px;right:10px;padding:3px 9px;border-radius:20px;font-size:9px;font-weight:800;letter-spacing:.8px;text-transform:uppercase;background:rgba(255,255,255,.08);color:#9bbdb5"><%= obj.is_a?(Hotel) ? 'Отель' : 'Жильё' %></div>
            </div>
            <div style="padding:14px 16px">
              <div style="font-size:14px;font-weight:700;color:#e8f5f1;margin-bottom:4px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis"><%= obj.name %></div>
              <div style="font-size:11px;color:#5a8078;margin-bottom:8px"><%= obj.city %></div>
              <div style="font-size:12px;color:#9bbdb5;margin-bottom:10px"><%= obj.is_a?(Hotel) ? obj.hotel_type : obj.property_type %></div>
              <div style="font-size:12px;color:#9bbdb5;margin-bottom:6px">₽<%= obj.respond_to?(:display_price) ? obj.display_price.to_i : 0 %> за ночь</div>
              <div style="font-size:11px;color:#5a8078;margin-bottom:12px"><%= obj.respond_to?(:availability_label) ? obj.availability_label : '' %></div>
              <% edit_path = obj.is_a?(Hotel) ? supervisor_edit_hotel_path(obj) : supervisor_edit_property_path(obj) %>
              <a href="<%= edit_path %>" style="display:inline-flex;align-items:center;gap:8px;padding:9px 14px;border-radius:12px;background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.1);color:#e8f5f1;text-decoration:none;font-size:12px;font-weight:700">Редактировать</a>
            </div>
          </div>
        <% end %>
      <% else %>
        <div class="col-span-full glass rounded-[24px] p-10 sm:p-16 text-center max-w-[540px] mx-auto">
          <div class="w-20 h-20 rounded-[24px] bg-tl/10 border border-tl/20 flex items-center justify-center text-tl mx-auto mb-6 text-4xl">🏠</div>
          <h2 class="font-serif text-tx mb-3" style="font-size:clamp(22px,2.4vw,30px)">Объектов пока нет</h2>
          <p class="text-tx2 text-sm leading-relaxed mb-8">Добавьте первое жильё — это займёт около 5 минут.</p>
          <a href="<%= supervisor_choice_path %>" class="inline-flex items-center gap-2 px-6 py-4 rounded-[14px] border-none text-bg font-extrabold text-sm cursor-pointer transition-all" style="background:linear-gradient(135deg,#1db896,#15a07f);box-shadow:0 8px 28px rgba(29,184,150,.35)" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform=''">
            <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>Добавить первый объект
          </a>
        </div>
      <% end %>
    </div>
    <div id="no-search" class="hidden text-center py-16"><div class="text-4xl mb-4">🔍</div><div class="text-tx2 text-sm">Ничего не найдено по запросу «<span id="no-q"></span>»</div></div>
  </main>
</div>

<script>
(function(){
  const c=document.getElementById('aurora'),ctx=c.getContext('2d');let W,H,t=0;
  const orbs=[{x:.15,y:.25,r:.4,col:'rgba(29,184,150,.14)',sp:.0003},{x:.85,y:.2,r:.35,col:'rgba(29,184,150,.1)',sp:.0005},{x:.4,y:.8,r:.38,col:'rgba(13,122,96,.11)',sp:.0002},{x:.9,y:.65,r:.3,col:'rgba(29,184,150,.09)',sp:.0006}];
  function resize(){W=c.width=window.innerWidth;H=c.height=window.innerHeight}resize();window.addEventListener('resize',resize);
  function draw(){ctx.clearRect(0,0,W,H);orbs.forEach(o=>{const ox=W*(o.x+.07*Math.sin(t*o.sp*3)),oy=H*(o.y+.05*Math.cos(t*o.sp*2)),r=Math.min(W,H)*o.r,g=ctx.createRadialGradient(ox,oy,0,ox,oy,r);g.addColorStop(0,o.col);g.addColorStop(1,'rgba(0,0,0,0)');ctx.fillStyle=g;ctx.beginPath();ctx.arc(ox,oy,r,0,Math.PI*2);ctx.fill()});t++;requestAnimationFrame(draw)}draw();})();

const objects = <%= (@hotels + @properties).to_json.html_safe %>;

function filterProps(){
  const q=document.getElementById('search-inp').value.trim().toLowerCase();
  document.getElementById('no-q').textContent=q;
  const filtered = objects.filter(o => o.name.toLowerCase().includes(q) || (o.city && o.city.toLowerCase().includes(q)) || (o.hotel_type && o.hotel_type.toLowerCase().includes(q)) || (o.property_type && o.property_type.toLowerCase().includes(q)));
  const grid = document.getElementById('props-grid');
  const noSearch = document.getElementById('no-search');
  if(!q || filtered.length){
    noSearch.classList.add('hidden');
    if(filtered.length){
      grid.innerHTML = '<div class="grid sm:grid-cols-2 xl:grid-cols-3 gap-4">' + filtered.map(o => `
        <div class="prop-card">
          <div style="height:150px;background:linear-gradient(135deg,#122720,#0d1c18);display:flex;align-items:center;justify-content:center;font-size:52px;position:relative">
            ${o.type === 'Hotel' ? '🏨' : '🏠'}
            <div style="position:absolute;top:10px;left:10px;padding:3px 10px;border-radius:20px;font-size:10px;font-weight:700;background:${o.status === 'active' ? 'rgba(29,184,150,.15)' : (o.status === 'rejected' ? 'rgba(242,79,107,.15)' : 'rgba(245,200,66,.15)')};color:${o.status === 'active' ? '#1db896' : (o.status === 'rejected' ? '#f87171' : '#f5c842')}">${o.status === 'active' ? 'Активен' : (o.status === 'rejected' ? 'Отклонён' : 'На проверке')}</div>
            <div style="position:absolute;top:10px;right:10px;padding:3px 9px;border-radius:20px;font-size:9px;font-weight:800;letter-spacing:.8px;text-transform:uppercase;background:rgba(255,255,255,.08);color:#9bbdb5">${o.type === 'Hotel' ? 'Отель' : 'Жильё'}</div>
          </div>
          <div style="padding:14px 16px">
            <div style="font-size:14px;font-weight:700;color:#e8f5f1;margin-bottom:4px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis">${o.name}</div>
            <div style="font-size:11px;color:#5a8078;margin-bottom:8px">${o.city}</div>
            <div style="font-size:12px;color:#9bbdb5">${o.hotel_type || o.property_type}</div>
          </div>
        </div>
      `).join('') + '</div>';
    } else {
      grid.innerHTML = '';
      noSearch.classList.remove('hidden');
    }
  } else {
    grid.innerHTML = '';
    noSearch.classList.remove('hidden');
  }
}
</script>
</body>
</html>
```

---

## `app/views/supervisor/dashboard/new_hotel.html.erb`

```
<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checqin — Супервайзор / Новый отель</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<script>
tailwind.config={theme:{extend:{
  colors:{tl:'#1db896',tl2:'#15a07f',bg:'#050f0c',bg2:'#091410',bg3:'#0d1c18',bg4:'#122720',tx:'#e8f5f1',tx2:'#9bbdb5',tx3:'#5a8078'},
  fontFamily:{serif:['"DM Serif Display"','serif'],sans:['"Plus Jakarta Sans"','sans-serif']},
}}}
</script>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:'Plus Jakarta Sans',sans-serif}
#aurora{position:fixed;inset:0;z-index:0;pointer-events:none;opacity:.42}
.glass{background:rgba(13,28,24,.88);backdrop-filter:blur(22px);border:1px solid rgba(29,184,150,.18)}
.glass-hdr{background:rgba(5,15,12,.86);backdrop-filter:blur(20px);border-bottom:1px solid rgba(29,184,150,.14)}
.fi{width:100%;background:rgba(255,255,255,.05);border:1.5px solid rgba(255,255,255,.12);border-radius:16px;color:#e8f5f1;font-family:'Plus Jakarta Sans',sans-serif;font-size:15px;font-weight:500;padding:18px 18px 14px;outline:none;transition:all .22s}
.fi:focus{border-color:#1db896;background:rgba(29,184,150,.06);box-shadow:0 0 0 3px rgba(29,184,150,.13)}
.fi::placeholder{color:#5a8078;font-weight:400}
.fi.err{border-color:#f24f6b!important;background:rgba(242,79,107,.07)!important;box-shadow:0 0 0 3px rgba(242,79,107,.13)!important}
.fi-label{display:block;font-size:11px;font-weight:800;letter-spacing:1.6px;text-transform:uppercase;color:#9bbdb5;margin-bottom:6px}
.fi-sel{width:100%;background:rgba(255,255,255,.05);border:1.5px solid rgba(255,255,255,.12);border-radius:16px;color:#e8f5f1;font-family:'Plus Jakarta Sans',sans-serif;font-size:15px;font-weight:500;padding:18px 44px 14px 18px;outline:none;transition:all .22s;appearance:none;cursor:pointer}
.fi-sel:focus{border-color:#1db896;background:rgba(29,184,150,.06);box-shadow:0 0 0 3px rgba(29,184,150,.13)}
.fi-sel option{background:#0d1c18;color:#e8f5f1}
.upload-z{border:2px dashed rgba(29,184,150,.28);border-radius:16px;background:rgba(29,184,150,.04);padding:30px 20px;text-align:center;cursor:pointer;transition:all .25s}
.upload-z:hover{border-color:rgba(29,184,150,.55);background:rgba(29,184,150,.08)}
</style>
</head>
<body class="bg-bg text-tx">
<canvas id="aurora"></canvas>

<div class="relative z-10 flex flex-col min-h-screen">
  <header class="glass-hdr sticky top-0 z-50 flex items-center justify-between px-4 sm:px-6 lg:px-10 py-3.5">
    <a href="<%= supervisor_root_path %>" class="flex items-center gap-2 text-tx2 hover:text-tl transition-colors text-sm font-semibold"><svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/></svg>Мои объекты</a>
    <div class="text-xs text-tx3 hidden sm:block">Объект с номерами</div>
    <div class="flex items-center gap-2">
      <div class="flex items-center gap-2.5 bg-white/[.04] border border-white/10 rounded-full pl-1 pr-3 py-1"><div class="w-7 h-7 rounded-full bg-tl/20 border border-tl/30 flex items-center justify-center text-tl text-xs font-bold"><%= current_user.email[0].upcase %></div><span class="text-sm font-semibold text-tx2 hidden sm:block"><%= current_user.email.split('@').first %></span></div>
      <%= button_to "Выйти", destroy_user_session_path, method: :delete, class: "px-4 py-2 rounded-[12px] border border-white/10 bg-white/[.04] text-tx2 font-semibold text-sm cursor-pointer transition-all hover:border-tl hover:text-tl", form: { data: { turbo: false } } %>
    </div>
  </header>
  <main class="flex-1 px-4 sm:px-6 lg:px-14 py-10 max-w-[860px] mx-auto w-full">
    <h1 class="font-serif text-tx mb-8" style="font-size:clamp(28px,4vw,48px)"><%= @hotel.persisted? ? 'Редактирование отеля' : 'Об объекте' %></h1>

    <%= form_with model: @hotel, url: (@hotel.persisted? ? supervisor_update_hotel_path(@hotel) : supervisor_create_hotel_path), method: (@hotel.persisted? ? :patch : :post), local: true, multipart: true, class: "flex flex-col gap-5" do |f| %>
      <div>
        <%= f.label :name, class: "fi-label" do %>Название <span class="text-red-400">*</span><% end %>
        <%= f.text_field :name, placeholder: "Например, Ромашка", class: "fi", maxlength: 80 %>
      </div>

      <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <div>
          <%= f.label :hotel_type, class: "fi-label" do %>Тип <span class="text-red-400">*</span><% end %>
          <div class="fi-wrap relative">
            <%= f.select :hotel_type, options_for_select(['Отель', 'База отдыха', 'Апарт-отель', 'Гостевой дом', 'Хостел', 'Санаторий', 'Глэмпинг', 'Другое']), { prompt: 'Выберите тип' }, class: "fi-sel" %>
            <div class="absolute right-4 top-1/2 -translate-y-1/2 text-tx3 pointer-events-none"><svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7"/></svg></div>
          </div>
        </div>
        <div>
          <%= f.label :chain, class: "fi-label" %>Отельная сеть, если есть
          <div class="fi-wrap relative">
            <%= f.select :chain, options_for_select(['Marriott', 'Hilton', 'Radisson', 'Hyatt', 'Novotel / Accor', 'Best Western', 'Другая', 'Без сети']), { include_blank: 'Например, Hilton' }, class: "fi-sel" %>
            <div class="absolute right-4 top-1/2 -translate-y-1/2 text-tx3 pointer-events-none"><svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7"/></svg></div>
          </div>
        </div>
      </div>

      <div>
        <%= f.label :city, class: "fi-label" do %>Город <span class="text-red-400">*</span><% end %>
        <%= f.text_field :city, placeholder: "Выберите город", class: "fi" %>
        <p class="text-xs text-tx3 mt-1.5">Только буквы, без цифр</p>
      </div>

      <div>
        <%= f.label :address, class: "fi-label" do %>Адрес <span class="text-red-400">*</span><% end %>
        <%= f.text_field :address, placeholder: "Улица и дом", class: "fi" %>
      </div>

      <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div>
          <%= f.label :base_price_per_night, class: "fi-label" do %>Цена за ночь, ₽ <span class="text-red-400">*</span><% end %>
          <%= f.number_field :base_price_per_night, min: 1, step: 1, placeholder: "4500", class: "fi" %>
          <p class="text-xs text-tx3 mt-1.5">Покажем эту цену на карточке отеля</p>
        </div>
        <div>
          <%= f.label :available_from, class: "fi-label" do %>Доступно с <span class="text-red-400">*</span><% end %>
          <%= f.date_field :available_from, class: "fi" %>
        </div>
        <div>
          <%= f.label :available_to, class: "fi-label" do %>Доступно до <span class="text-red-400">*</span><% end %>
          <%= f.date_field :available_to, class: "fi" %>
        </div>
      </div>

      <div>
        <%= f.label :description, class: "fi-label" %>Описание
        <%= f.text_area :description, rows: 4, placeholder: "Расскажите об отеле...", class: "fi" %>
      </div>

      <div>
        <%= f.label :photos, class: "fi-label" do %>Фотографии объекта <span class="text-red-400">*</span><% end %>
        <div class="upload-z" onclick="document.getElementById('hotel_photos').click()">
          <div class="w-12 h-12 rounded-[14px] bg-tl/10 border border-tl/20 flex items-center justify-center text-tl mx-auto mb-3"><svg class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg></div>
          <p class="text-sm font-semibold text-tx mb-1">Нажмите для загрузки</p>
          <p class="text-xs text-tx3">JPG, PNG &middot; <span class="text-tl font-semibold">Минимум 3 фото</span></p>
        </div>
        <%= f.file_field :photos, multiple: true, class: "hidden", id: "hotel_photos", onchange: "handlePhotos(this)" %>
        <div id="photo-preview" class="flex flex-wrap gap-2 mt-3"></div>
        <div id="photo-count" class="text-xs text-tx3 mt-1.5"></div>
      </div>

      <div id="form-err" class="hidden px-4 py-3 rounded-[13px] text-sm font-medium flex items-center gap-2" style="background:rgba(242,79,107,.1);border:1px solid rgba(242,79,107,.25);color:#f87171">
        <svg class="w-4 h-4 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/></svg>
        <span id="form-err-t"></span>
      </div>

      <%= f.submit "Зарегистрировать объект", class: "w-full sm:w-auto sm:self-start py-4 px-8 rounded-[16px] border-none text-bg font-extrabold text-sm cursor-pointer flex items-center justify-center gap-2 transition-all", style: "background:linear-gradient(135deg,#1db896,#15a07f);box-shadow:0 8px 28px rgba(29,184,150,.35)" %>
    <% end %>
  </main>
</div>

<script>
(function(){
  const c=document.getElementById('aurora'),ctx=c.getContext('2d');let W,H,t=0;
  const orbs=[{x:.15,y:.25,r:.4,col:'rgba(29,184,150,.14)',sp:.0003},{x:.85,y:.2,r:.35,col:'rgba(29,184,150,.1)',sp:.0005},{x:.4,y:.8,r:.38,col:'rgba(13,122,96,.11)',sp:.0002},{x:.9,y:.65,r:.3,col:'rgba(29,184,150,.09)',sp:.0006}];
  function resize(){W=c.width=window.innerWidth;H=c.height=window.innerHeight}resize();window.addEventListener('resize',resize);
  function draw(){ctx.clearRect(0,0,W,H);orbs.forEach(o=>{const ox=W*(o.x+.07*Math.sin(t*o.sp*3)),oy=H*(o.y+.05*Math.cos(t*o.sp*2)),r=Math.min(W,H)*o.r,g=ctx.createRadialGradient(ox,oy,0,ox,oy,r);g.addColorStop(0,o.col);g.addColorStop(1,'rgba(0,0,0,0)');ctx.fillStyle=g;ctx.beginPath();ctx.arc(ox,oy,r,0,Math.PI*2);ctx.fill()});t++;requestAnimationFrame(draw)}draw();})();

function handlePhotos(input){
  const files = input.files;
  const preview = document.getElementById('photo-preview');
  const count = document.getElementById('photo-count');
  preview.innerHTML = '';
  count.textContent = files.length ? `Загружено: ${files.length} фото` : '';
  Array.from(files).slice(0,8).forEach(f => {
    const url = URL.createObjectURL(f);
    const div = document.createElement('div');
    div.style.cssText = 'width:70px;height:70px;border-radius:10px;overflow:hidden;border:1px solid rgba(255,255,255,.1);flex-shrink:0';
    div.innerHTML = `<img src="${url}" style="width:100%;height:100%;object-fit:cover">`;
    preview.appendChild(div);
  });
}
</script>
</body>
</html>
```

---

## `app/views/supervisor/dashboard/new_property.html.erb`

```
<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checqin — Супервайзор / Новое жильё</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<script>
tailwind.config={theme:{extend:{
  colors:{tl:'#1db896',tl2:'#15a07f',bg:'#050f0c',bg2:'#091410',bg3:'#0d1c18',bg4:'#122720',tx:'#e8f5f1',tx2:'#9bbdb5',tx3:'#5a8078'},
  fontFamily:{serif:['"DM Serif Display"','serif'],sans:['"Plus Jakarta Sans"','sans-serif']},
}}}
</script>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:'Plus Jakarta Sans',sans-serif}
#aurora{position:fixed;inset:0;z-index:0;pointer-events:none;opacity:.42}
.glass{background:rgba(13,28,24,.88);backdrop-filter:blur(22px);border:1px solid rgba(29,184,150,.18)}
.glass-hdr{background:rgba(5,15,12,.86);backdrop-filter:blur(20px);border-bottom:1px solid rgba(29,184,150,.14)}
.fi{width:100%;background:rgba(255,255,255,.05);border:1.5px solid rgba(255,255,255,.12);border-radius:16px;color:#e8f5f1;font-family:'Plus Jakarta Sans',sans-serif;font-size:15px;font-weight:500;padding:18px 18px 14px;outline:none;transition:all .22s}
.fi:focus{border-color:#1db896;background:rgba(29,184,150,.06);box-shadow:0 0 0 3px rgba(29,184,150,.13)}
.fi::placeholder{color:#5a8078;font-weight:400}
.fi.err{border-color:#f24f6b!important;background:rgba(242,79,107,.07)!important;box-shadow:0 0 0 3px rgba(242,79,107,.13)!important}
.fi-label{display:block;font-size:11px;font-weight:800;letter-spacing:1.6px;text-transform:uppercase;color:#9bbdb5;margin-bottom:6px}
.fi-sel{width:100%;background:rgba(255,255,255,.05);border:1.5px solid rgba(255,255,255,.12);border-radius:16px;color:#e8f5f1;font-family:'Plus Jakarta Sans',sans-serif;font-size:15px;font-weight:500;padding:18px 44px 14px 18px;outline:none;transition:all .22s;appearance:none;cursor:pointer}
.fi-sel:focus{border-color:#1db896;background:rgba(29,184,150,.06);box-shadow:0 0 0 3px rgba(29,184,150,.13)}
.fi-sel option{background:#0d1c18;color:#e8f5f1}
.cnt-row{display:flex;align-items:center;background:rgba(255,255,255,.05);border:1.5px solid rgba(255,255,255,.12);border-radius:16px;overflow:hidden}
.cnt-btn{width:52px;padding:16px 0;display:flex;align-items:center;justify-content:center;font-size:24px;font-weight:300;color:#1db896;cursor:pointer;transition:all .2s;border:none;background:transparent}
.cnt-btn:hover{background:rgba(29,184,150,.12)}
.cnt-val{flex:1;text-align:center;font-size:17px;font-weight:800;color:#e8f5f1;padding:16px 0}
.upload-z{border:2px dashed rgba(29,184,150,.28);border-radius:16px;background:rgba(29,184,150,.04);padding:30px 20px;text-align:center;cursor:pointer;transition:all .25s}
.upload-z:hover{border-color:rgba(29,184,150,.55);background:rgba(29,184,150,.08)}
</style>
</head>
<body class="bg-bg text-tx">
<canvas id="aurora"></canvas>

<div class="relative z-10 flex flex-col min-h-screen">
  <header class="glass-hdr sticky top-0 z-50 flex items-center justify-between px-4 sm:px-6 lg:px-10 py-3.5">
    <a href="<%= supervisor_root_path %>" class="flex items-center gap-2 text-tx2 hover:text-tl transition-colors text-sm font-semibold"><svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/></svg>Мои объекты</a>
    <div class="text-xs text-tx3 hidden sm:block">Жильё целиком</div>
    <div class="flex items-center gap-2">
      <div class="flex items-center gap-2.5 bg-white/[.04] border border-white/10 rounded-full pl-1 pr-3 py-1"><div class="w-7 h-7 rounded-full bg-tl/20 border border-tl/30 flex items-center justify-center text-tl text-xs font-bold"><%= current_user.email[0].upcase %></div><span class="text-sm font-semibold text-tx2 hidden sm:block"><%= current_user.email.split('@').first %></span></div>
      <%= button_to "Выйти", destroy_user_session_path, method: :delete, class: "px-4 py-2 rounded-[12px] border border-white/10 bg-white/[.04] text-tx2 font-semibold text-sm cursor-pointer transition-all hover:border-tl hover:text-tl", form: { data: { turbo: false } } %>
    </div>
  </header>
  <main class="flex-1 px-4 sm:px-6 lg:px-14 py-10 max-w-[860px] mx-auto w-full">
    <h1 class="font-serif text-tx mb-8" style="font-size:clamp(28px,4vw,48px)"><%= @property.persisted? ? 'Редактирование жилья' : 'Об объекте' %></h1>

    <%= form_with model: @property, url: (@property.persisted? ? supervisor_update_property_path(@property) : supervisor_create_property_path), method: (@property.persisted? ? :patch : :post), local: true, multipart: true, class: "flex flex-col gap-5" do |f| %>
      <div>
        <%= f.label :name, class: "fi-label" do %>Название <span class="text-red-400">*</span><% end %>
        <%= f.text_field :name, placeholder: "Например, Уютная студия в центре города", class: "fi", maxlength: 80 %>
      </div>

      <div>
        <%= f.label :property_type, class: "fi-label" do %>Тип <span class="text-red-400">*</span><% end %>
        <div class="fi-wrap relative">
          <%= f.select :property_type, options_for_select(['Квартира', 'Апартаменты', 'Студия', 'Комната', 'Дом / коттедж', 'Таунхаус', 'Вилла', 'Другое']), { prompt: 'Например, квартира' }, class: "fi-sel" %>
          <div class="absolute right-4 top-1/2 -translate-y-1/2 text-tx3 pointer-events-none"><svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7"/></svg></div>
        </div>
      </div>

      <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <div>
          <%= f.label :rooms_count, class: "fi-label" %>Количество комнат
          <div class="cnt-row">
            <button type="button" class="cnt-btn" onclick="adjC('rooms_count', -1, 0)">−</button>
            <div class="cnt-val" id="rooms_count_val">0</div>
            <%= f.number_field :rooms_count, id: "rooms_count_input", value: 0, class: "hidden" %>
            <button type="button" class="cnt-btn" onclick="adjC('rooms_count', 1, 0)">+</button>
          </div>
          <p class="text-xs text-tx3 mt-1.5">Укажите 0, если у вас студия</p>
        </div>
        <div>
          <%= f.label :area, class: "fi-label" do %>Площадь объекта, м² <span class="text-red-400">*</span><% end %>
          <%= f.number_field :area, step: 0.5, min: 1, placeholder: "20", class: "fi" %>
        </div>
      </div>

      <div>
        <%= f.label :city, class: "fi-label" do %>Город <span class="text-red-400">*</span><% end %>
        <%= f.text_field :city, placeholder: "Например, Москва", class: "fi" %>
        <p class="text-xs text-tx3 mt-1.5">Только буквы, без цифр</p>
      </div>

      <div>
        <%= f.label :address, class: "fi-label" do %>Адрес <span class="text-red-400">*</span><% end %>
        <%= f.text_field :address, placeholder: "Точный адрес, чтобы гости не потерялись", class: "fi" %>
      </div>

      <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div>
          <%= f.label :base_price_per_night, class: "fi-label" do %>Цена за ночь, ₽ <span class="text-red-400">*</span><% end %>
          <%= f.number_field :base_price_per_night, min: 1, step: 1, placeholder: "3500", class: "fi" %>
        </div>
        <div>
          <%= f.label :available_from, class: "fi-label" do %>Доступно с <span class="text-red-400">*</span><% end %>
          <%= f.date_field :available_from, class: "fi" %>
        </div>
        <div>
          <%= f.label :available_to, class: "fi-label" do %>Доступно до <span class="text-red-400">*</span><% end %>
          <%= f.date_field :available_to, class: "fi" %>
        </div>
      </div>

      <div>
        <%= f.label :guests_capacity, class: "fi-label" %>Количество гостей
        <div class="cnt-row" style="max-width:200px">
          <button type="button" class="cnt-btn" onclick="adjC('guests_capacity', -1, 1)">−</button>
          <div class="cnt-val" id="guests_capacity_val">1</div>
          <%= f.number_field :guests_capacity, id: "guests_capacity_input", value: 1, class: "hidden" %>
          <button type="button" class="cnt-btn" onclick="adjC('guests_capacity', 1, 1)">+</button>
        </div>
      </div>

      <div>
        <%= f.label :description, class: "fi-label" %>Описание
        <%= f.text_area :description, rows: 4, placeholder: "Расскажите о жилье...", class: "fi" %>
      </div>

      <div>
        <%= f.label :photos, class: "fi-label" do %>Фотографии объекта <span class="text-red-400">*</span><% end %>
        <div class="upload-z" onclick="document.getElementById('property_photos').click()">
          <div class="w-12 h-12 rounded-[14px] bg-tl/10 border border-tl/20 flex items-center justify-center text-tl mx-auto mb-3"><svg class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg></div>
          <p class="text-sm font-semibold text-tx mb-1">Нажмите для загрузки</p>
          <p class="text-xs text-tx3">JPG, PNG &middot; <span class="text-tl font-semibold">Минимум 3 фото</span></p>
        </div>
        <%= f.file_field :photos, multiple: true, class: "hidden", id: "property_photos", onchange: "handlePhotos(this)" %>
        <div id="photo-preview" class="flex flex-wrap gap-2 mt-3"></div>
        <div id="photo-count" class="text-xs text-tx3 mt-1.5"></div>
      </div>

      <div id="form-err" class="hidden px-4 py-3 rounded-[13px] text-sm font-medium flex items-center gap-2" style="background:rgba(242,79,107,.1);border:1px solid rgba(242,79,107,.25);color:#f87171">
        <svg class="w-4 h-4 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/></svg>
        <span id="form-err-t"></span>
      </div>

      <%= f.submit "Зарегистрировать объект", class: "w-full sm:w-auto sm:self-start py-4 px-8 rounded-[16px] border-none text-bg font-extrabold text-sm cursor-pointer flex items-center justify-center gap-2 transition-all", style: "background:linear-gradient(135deg,#1db896,#15a07f);box-shadow:0 8px 28px rgba(29,184,150,.35)" %>
    <% end %>
  </main>
</div>

<script>
(function(){
  const c=document.getElementById('aurora'),ctx=c.getContext('2d');let W,H,t=0;
  const orbs=[{x:.15,y:.25,r:.4,col:'rgba(29,184,150,.14)',sp:.0003},{x:.85,y:.2,r:.35,col:'rgba(29,184,150,.1)',sp:.0005},{x:.4,y:.8,r:.38,col:'rgba(13,122,96,.11)',sp:.0002},{x:.9,y:.65,r:.3,col:'rgba(29,184,150,.09)',sp:.0006}];
  function resize(){W=c.width=window.innerWidth;H=c.height=window.innerHeight}resize();window.addEventListener('resize',resize);
  function draw(){ctx.clearRect(0,0,W,H);orbs.forEach(o=>{const ox=W*(o.x+.07*Math.sin(t*o.sp*3)),oy=H*(o.y+.05*Math.cos(t*o.sp*2)),r=Math.min(W,H)*o.r,g=ctx.createRadialGradient(ox,oy,0,ox,oy,r);g.addColorStop(0,o.col);g.addColorStop(1,'rgba(0,0,0,0)');ctx.fillStyle=g;ctx.beginPath();ctx.arc(ox,oy,r,0,Math.PI*2);ctx.fill()});t++;requestAnimationFrame(draw)}draw();})();

function adjC(field, delta, minVal){
  const valEl = document.getElementById(`${field}_val`);
  const input = document.getElementById(`${field}_input`);
  let current = parseInt(valEl.textContent) || minVal;
  let newVal = current + delta;
  if(newVal < minVal) newVal = minVal;
  if(newVal > 20) newVal = 20;
  valEl.textContent = newVal;
  if(input) input.value = newVal;
}

function handlePhotos(input){
  const files = input.files;
  const preview = document.getElementById('photo-preview');
  const count = document.getElementById('photo-count');
  preview.innerHTML = '';
  count.textContent = files.length ? `Загружено: ${files.length} фото` : '';
  Array.from(files).slice(0,8).forEach(f => {
    const url = URL.createObjectURL(f);
    const div = document.createElement('div');
    div.style.cssText = 'width:70px;height:70px;border-radius:10px;overflow:hidden;border:1px solid rgba(255,255,255,.1);flex-shrink:0';
    div.innerHTML = `<img src="${url}" style="width:100%;height:100%;object-fit:cover">`;
    preview.appendChild(div);
  });
}
</script>
</body>
</html>
```

---

## `app/views/supervisor/dashboard/success.html.erb`

```
<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checqin — Успешно добавлено</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<script>
tailwind.config={theme:{extend:{
  colors:{tl:'#1db896',tl2:'#15a07f',bg:'#050f0c',bg2:'#091410',bg3:'#0d1c18',bg4:'#122720',tx:'#e8f5f1',tx2:'#9bbdb5',tx3:'#5a8078'},
  fontFamily:{serif:['"DM Serif Display"','serif'],sans:['"Plus Jakarta Sans"','sans-serif']},
}}}
</script>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:'Plus Jakarta Sans',sans-serif}
#aurora{position:fixed;inset:0;z-index:0;pointer-events:none;opacity:.42}
.glass{background:rgba(13,28,24,.88);backdrop-filter:blur(22px);border:1px solid rgba(29,184,150,.18)}
.glass-hdr{background:rgba(5,15,12,.86);backdrop-filter:blur(20px);border-bottom:1px solid rgba(29,184,150,.14)}
</style>
</head>
<body class="bg-bg text-tx">
<canvas id="aurora"></canvas>

<div class="relative z-10 flex flex-col min-h-screen">
  <header class="glass-hdr sticky top-0 z-50 flex items-center justify-between px-4 sm:px-6 lg:px-10 py-3.5">
    <div><svg width="108" height="29" viewBox="0 0 240 60" fill="none"><path d="M44 10 C24 10 8 21 8 35 C8 49 24 56 44 56" stroke="#1db896" stroke-width="7" stroke-linecap="round" fill="none"/><ellipse cx="9" cy="35" rx="7" ry="9" fill="#1db896"/><path d="M9 44 L6 53 L9 49 L12 53 Z" fill="#1db896"/><circle cx="9" cy="33" r="3" fill="#050f0c"/><rect x="8" y="35.5" width="2" height="4" rx="1" fill="#050f0c"/><path d="M56 12 L56 48 M56 30 Q63 21 73 30 L73 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/><path d="M82 36 Q82 24 93 24 Q103 24 103 33 L82 33 M82 36 Q82 48 93 48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/><path d="M130 28 Q120 20 111 33 Q102 46 114 47 Q122 47 130 40" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/><path d="M150 24 Q137 24 137 35 Q137 47 150 47 Q163 47 163 35 Q163 28 158 25 M161 44 L170 54" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" fill="none"/><circle cx="178" cy="18" r="4" fill="#1db896"/><line x1="178" y1="27" x2="178" y2="48" stroke="#1db896" stroke-width="5.5" stroke-linecap="round"/><path d="M188 48 L188 27 Q188 27 198 38 Q208 48 208 48 L208 27" stroke="#1db896" stroke-width="5.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/></svg></div>
    <div class="flex items-center gap-2">
      <%= button_to "Выйти", destroy_user_session_path, method: :delete, class: "px-4 py-2 rounded-[12px] border border-white/10 bg-white/[.04] text-tx2 font-semibold text-sm cursor-pointer transition-all hover:border-tl hover:text-tl", form: { data: { turbo: false } } %>
      <a href="<%= supervisor_root_path %>" class="w-9 h-9 rounded-full border border-white/15 bg-white/[.04] flex items-center justify-center text-tx2 hover:border-tl hover:text-tl transition-all text-lg">✕</a>
    </div>
  </header>
  <main class="flex-1 flex items-center justify-center px-4 py-14">
    <div class="glass rounded-[26px] p-8 sm:p-12 text-center max-w-[520px] w-full shadow-[0_24px_80px_rgba(0,0,0,.45)]">
      <div class="w-20 h-20 rounded-[24px] bg-tl/10 border border-tl/25 flex items-center justify-center text-tl mx-auto mb-6 text-4xl" style="box-shadow:0 0 50px rgba(29,184,150,.2)">
        <%= @object.is_a?(Hotel) ? '🏨' : '🏠' %>
      </div>
      <h2 class="font-serif text-tx mb-3" style="font-size:clamp(22px,2.6vw,32px)"><%= @object.is_a?(Hotel) ? 'Отель добавлен!' : 'Жильё добавлено!' %></h2>
      <p class="text-tx2 text-sm leading-relaxed mb-2">Объект <span class="text-tl font-semibold">«<%= @object.name %>»</span> отправлен на проверку.</p>
      <p class="text-tx3 text-xs mb-8">Обычно проверка занимает 1–2 рабочих дня. Мы уведомим вас по email.</p>
      <div class="bg-white/[.03] border border-white/8 rounded-[16px] p-4 mb-6 text-left">
        <div class="text-[10px] font-extrabold tracking-[1.4px] uppercase text-tx3 mb-3">Детали объекта</div>
        <div class="flex flex-col gap-2">
          <div class="flex justify-between text-sm"><span class="text-tx3">Тип</span><span class="text-tx font-semibold"><%= @object.is_a?(Hotel) ? @object.hotel_type : @object.property_type %></span></div>
          <div class="flex justify-between text-sm"><span class="text-tx3">Город</span><span class="text-tx font-semibold"><%= @object.city %></span></div>
          <div class="flex justify-between text-sm"><span class="text-tx3">Статус</span><span class="font-semibold" style="color:#f5c842"><%= @object.status == 'active' ? 'Активен' : (@object.status == 'rejected' ? 'Отклонён' : 'На проверке') %></span></div>
        </div>
      </div>
      <div class="flex flex-col sm:flex-row gap-3 justify-center">
        <a href="<%= supervisor_choice_path %>" class="px-5 py-3.5 rounded-[14px] border border-white/10 bg-white/[.04] text-tx2 font-semibold text-sm cursor-pointer transition-all hover:border-tl/40 hover:text-tx">Добавить ещё объект</a>
        <a href="<%= supervisor_root_path %>" class="px-5 py-3.5 rounded-[14px] border-none text-bg font-extrabold text-sm cursor-pointer transition-all" style="background:linear-gradient(135deg,#1db896,#15a07f);box-shadow:0 6px 20px rgba(29,184,150,.35)">К моим объектам →</a>
      </div>
    </div>
  </main>
</div>

<script>
(function(){
  const c=document.getElementById('aurora'),ctx=c.getContext('2d');let W,H,t=0;
  const orbs=[{x:.15,y:.25,r:.4,col:'rgba(29,184,150,.14)',sp:.0003},{x:.85,y:.2,r:.35,col:'rgba(29,184,150,.1)',sp:.0005},{x:.4,y:.8,r:.38,col:'rgba(13,122,96,.11)',sp:.0002},{x:.9,y:.65,r:.3,col:'rgba(29,184,150,.09)',sp:.0006}];
  function resize(){W=c.width=window.innerWidth;H=c.height=window.innerHeight}resize();window.addEventListener('resize',resize);
  function draw(){ctx.clearRect(0,0,W,H);orbs.forEach(o=>{const ox=W*(o.x+.07*Math.sin(t*o.sp*3)),oy=H*(o.y+.05*Math.cos(t*o.sp*2)),r=Math.min(W,H)*o.r,g=ctx.createRadialGradient(ox,oy,0,ox,oy,r);g.addColorStop(0,o.col);g.addColorStop(1,'rgba(0,0,0,0)');ctx.fillStyle=g;ctx.beginPath();ctx.arc(ox,oy,r,0,Math.PI*2);ctx.fill()});t++;requestAnimationFrame(draw)}draw();})();
</script>
</body>
</html>
```

---

## `public/404.html`

```
<!DOCTYPE html>
<html>
<head>
  <title>The page you were looking for doesn't exist (404)</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <style>
  .rails-default-error-page {
    background-color: #EFEFEF;
    color: #2E2F30;
    text-align: center;
    font-family: arial, sans-serif;
    margin: 0;
  }

  .rails-default-error-page div.dialog {
    width: 95%;
    max-width: 33em;
    margin: 4em auto 0;
  }

  .rails-default-error-page div.dialog > div {
    border: 1px solid #CCC;
    border-right-color: #999;
    border-left-color: #999;
    border-bottom-color: #BBB;
    border-top: #B00100 solid 4px;
    border-top-left-radius: 9px;
    border-top-right-radius: 9px;
    background-color: white;
    padding: 7px 12% 0;
    box-shadow: 0 3px 8px rgba(50, 50, 50, 0.17);
  }

  .rails-default-error-page h1 {
    font-size: 100%;
    color: #730E15;
    line-height: 1.5em;
  }

  .rails-default-error-page div.dialog > p {
    margin: 0 0 1em;
    padding: 1em;
    background-color: #F7F7F7;
    border: 1px solid #CCC;
    border-right-color: #999;
    border-left-color: #999;
    border-bottom-color: #999;
    border-bottom-left-radius: 4px;
    border-bottom-right-radius: 4px;
    border-top-color: #DADADA;
    color: #666;
    box-shadow: 0 3px 8px rgba(50, 50, 50, 0.17);
  }
  </style>
</head>

<body class="rails-default-error-page">
  <!-- This file lives in public/404.html -->
  <div class="dialog">
    <div>
      <h1>The page you were looking for doesn't exist.</h1>
      <p>You may have mistyped the address or the page may have moved.</p>
    </div>
    <p>If you are the application owner check the logs for more information.</p>
  </div>
</body>
</html>
```

---

## `public/422.html`

```
<!DOCTYPE html>
<html>
<head>
  <title>The change you wanted was rejected (422)</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <style>
  .rails-default-error-page {
    background-color: #EFEFEF;
    color: #2E2F30;
    text-align: center;
    font-family: arial, sans-serif;
    margin: 0;
  }

  .rails-default-error-page div.dialog {
    width: 95%;
    max-width: 33em;
    margin: 4em auto 0;
  }

  .rails-default-error-page div.dialog > div {
    border: 1px solid #CCC;
    border-right-color: #999;
    border-left-color: #999;
    border-bottom-color: #BBB;
    border-top: #B00100 solid 4px;
    border-top-left-radius: 9px;
    border-top-right-radius: 9px;
    background-color: white;
    padding: 7px 12% 0;
    box-shadow: 0 3px 8px rgba(50, 50, 50, 0.17);
  }

  .rails-default-error-page h1 {
    font-size: 100%;
    color: #730E15;
    line-height: 1.5em;
  }

  .rails-default-error-page div.dialog > p {
    margin: 0 0 1em;
    padding: 1em;
    background-color: #F7F7F7;
    border: 1px solid #CCC;
    border-right-color: #999;
    border-left-color: #999;
    border-bottom-color: #999;
    border-bottom-left-radius: 4px;
    border-bottom-right-radius: 4px;
    border-top-color: #DADADA;
    color: #666;
    box-shadow: 0 3px 8px rgba(50, 50, 50, 0.17);
  }
  </style>
</head>

<body class="rails-default-error-page">
  <!-- This file lives in public/422.html -->
  <div class="dialog">
    <div>
      <h1>The change you wanted was rejected.</h1>
      <p>Maybe you tried to change something you didn't have access to.</p>
    </div>
    <p>If you are the application owner check the logs for more information.</p>
  </div>
</body>
</html>
```

---

## `public/500.html`

```
<!DOCTYPE html>
<html>
<head>
  <title>We're sorry, but something went wrong (500)</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <style>
  .rails-default-error-page {
    background-color: #EFEFEF;
    color: #2E2F30;
    text-align: center;
    font-family: arial, sans-serif;
    margin: 0;
  }

  .rails-default-error-page div.dialog {
    width: 95%;
    max-width: 33em;
    margin: 4em auto 0;
  }

  .rails-default-error-page div.dialog > div {
    border: 1px solid #CCC;
    border-right-color: #999;
    border-left-color: #999;
    border-bottom-color: #BBB;
    border-top: #B00100 solid 4px;
    border-top-left-radius: 9px;
    border-top-right-radius: 9px;
    background-color: white;
    padding: 7px 12% 0;
    box-shadow: 0 3px 8px rgba(50, 50, 50, 0.17);
  }

  .rails-default-error-page h1 {
    font-size: 100%;
    color: #730E15;
    line-height: 1.5em;
  }

  .rails-default-error-page div.dialog > p {
    margin: 0 0 1em;
    padding: 1em;
    background-color: #F7F7F7;
    border: 1px solid #CCC;
    border-right-color: #999;
    border-left-color: #999;
    border-bottom-color: #999;
    border-bottom-left-radius: 4px;
    border-bottom-right-radius: 4px;
    border-top-color: #DADADA;
    color: #666;
    box-shadow: 0 3px 8px rgba(50, 50, 50, 0.17);
  }
  </style>
</head>

<body class="rails-default-error-page">
  <!-- This file lives in public/500.html -->
  <div class="dialog">
    <div>
      <h1>We're sorry, but something went wrong.</h1>
    </div>
    <p>If you are the application owner check the logs for more information.</p>
  </div>
</body>
</html>
```
