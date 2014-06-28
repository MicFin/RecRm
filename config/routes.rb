Rails.application.routes.draw do
  resources :recipes
  resources :appointments
  resources :families

  get 'welcome/index'
  get 'home', to: 'home#index', as: 'home'

  devise_for :users, :dietitians
  root to: 'welcome#index'
end
