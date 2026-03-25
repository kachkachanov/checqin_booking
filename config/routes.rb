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
  resources :hotels do
    resources :rooms
  end
  resources :properties, only: [:show]
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
  end

  namespace :admin do
    root 'dashboard#index'
    patch 'hotels/:id/approve', to: 'dashboard#approve_hotel', as: :approve_hotel
    patch 'hotels/:id/reject', to: 'dashboard#reject_hotel', as: :reject_hotel
    patch 'properties/:id/approve', to: 'dashboard#approve_property', as: :approve_property
    patch 'properties/:id/reject', to: 'dashboard#reject_property', as: :reject_property
  end
end
