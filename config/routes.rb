Rails.application.routes.draw do
  resources :appointments

  devise_for :dietitians
  resources :families

  get 'welcome/index'

  devise_for :users
  root to: 'welcome#index'
end
