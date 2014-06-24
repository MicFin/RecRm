Rails.application.routes.draw do
  resources :families

  get 'welcome/index'

  devise_for :users
  root to: 'welcome#index'
end
