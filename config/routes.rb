Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  root 'hotels#index'
  get 'search', to: 'hotels#search', as: :search_hotels
  resource :favorites, only: [:show] do
    post 'toggle/:hotel_id', to: 'favorites#toggle', as: :toggle
  end
  patch 'currency', to: 'currencies#update', as: :currency
  patch 'account/password', to: 'accounts#update_password', as: :account_password
  resources :bookings, only: [:index, :show]
  resources :hotels do
    resources :bookings, only: [:create]
    resources :rooms
  end
  resources :properties, only: [:show]
  
  # Youth features
  get 'vibes/hotels/:vibe_name', to: 'vibes#hotels', as: :vibe_hotels
  get 'hotel_swipe', to: 'hotel_swipe#index', as: :hotel_swipe_index
  get 'hotel_swipe/next', to: 'hotel_swipe#next_hotel', as: :hotel_swipe_next
  post 'hotel_swipe/like/:hotel_id', to: 'hotel_swipe#like', as: :hotel_swipe_like
  post 'hotel_swipe/skip/:hotel_id', to: 'hotel_swipe#skip', as: :hotel_swipe_skip
  get 'hotel_swipe/liked', to: 'hotel_swipe#liked_hotels', as: :hotel_swipe_liked
  resources :dream_hotels, only: [:index, :create, :destroy]
  get 'travel_streak', to: 'travel_streak#show', as: :travel_streak
  namespace :supervisor do
    root 'dashboard#index'
    get 'choice', to: 'dashboard#choice'
    get 'new_hotel', to: 'dashboard#new_hotel'
    post 'create_hotel', to: 'dashboard#create_hotel'
    get 'hotels/:id/edit', to: 'dashboard#edit_hotel', as: :edit_hotel
    patch 'hotels/:id', to: 'dashboard#update_hotel', as: :update_hotel
    get 'new_property', to: 'dashboard#new_property'
    post 'create_property', to: 'dashboard#create_property'
    get 'properties/:id/edit', to: 'dashboard#edit_property', as: :edit_property
    patch 'properties/:id', to: 'dashboard#update_property', as: :update_property
    get 'success', to: 'dashboard#success'

    get 'bookings', to: 'bookings#index', as: :bookings
    get 'analytics', to: 'analytics#index', as: :analytics
  end

  namespace :admin do
    root 'dashboard#index'
    patch 'hotels/:id/approve', to: 'dashboard#approve_hotel', as: :approve_hotel
    patch 'hotels/:id/reject', to: 'dashboard#reject_hotel', as: :reject_hotel
    patch 'properties/:id/approve', to: 'dashboard#approve_property', as: :approve_property
    patch 'properties/:id/reject', to: 'dashboard#reject_property', as: :reject_property
  end
end
