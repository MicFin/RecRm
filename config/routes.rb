Rails.application.routes.draw do
  resources :recipes do
    get :autocomplete_ingredient_name, :on => :collection
  end

  resources :appointments
  resources :ingredients
  resources :allergens
  resources :characteristics
  devise_for :dietitians
  resources :families

  get 'welcome/index'

  devise_for :users
  root to: 'welcome#index'
end
