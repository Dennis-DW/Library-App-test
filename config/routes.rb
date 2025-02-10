
# config/routes.rb
Rails.application.routes.draw do
  root "books#index"

  resources :books, only: [:index, :show] do
    resources :borrowings, only: [:create]
  end

  resources :borrowings, only: [:update]

  resources :users, only: [:new, :create, :show]

  # Named routes for convenience.
  get  'signup',  to: 'users#new',     as: 'signup'
  get  'profile', to: 'users#show',    as: 'profile'
  get  'login',   to: 'sessions#new',  as: 'login'
  post 'login',   to: 'sessions#create'
  delete 'logout',to: 'sessions#destroy', as: 'logout'
end
