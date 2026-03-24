Rails.application.routes.draw do
  # Devise для аутентификации
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  # Главная страница
  root 'hotels#index'

  # Поиск отелей
  get 'search', to: 'hotels#search', as: :search_hotels

  # Избранное
  resource :favorites, only: [:show] do
    post 'toggle/:hotel_id', to: 'favorites#toggle', as: :toggle
  end

  # Отели и номера
  resources :hotels do
    resources :rooms
  end

  # Жильё целиком
  resources :properties, only: [:show]

  # Супервайзор
  namespace :supervisor do
    root 'dashboard#index'
    get 'choice', to: 'dashboard#choice'
    get 'new_hotel', to: 'dashboard#new_hotel'
    post 'create_hotel', to: 'dashboard#create_hotel'
    get 'new_property', to: 'dashboard#new_property'
    post 'create_property', to: 'dashboard#create_property'
    get 'success', to: 'dashboard#success'
  end
end
