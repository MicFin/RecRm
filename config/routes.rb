Rails.application.routes.draw do

  resources :recipes do
    get :autocomplete_ingredient_name, :on => :collection
  end
  # manual route 
  get '/recipes/edit_recipe_group/:id', to: 'recipes#edit_recipe_group', as: 'edit_recipe_group'

  resources :appointments
  resources :ingredients
  resources :allergens
  resources :characteristics
  resources :families
  resources :ingredients_recipes
  resources :allergens_ingredients
  resources :recipes_patient_groups

  get 'welcome/index'
  get 'home', to: 'home#index', as: 'home'

  devise_for :users, :dietitians
  root to: 'welcome#index'
end
