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
  resources :ingredients_recipes

  get 'welcome/index'
  get 'home', to: 'home#index', as: 'home'

  devise_for :users, :dietitians
  root to: 'welcome#index'
end
