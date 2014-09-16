Rails.application.routes.draw do


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_scope :admin_user do
    authenticated :admin_user do 
      root to: "admin/dashboard#index"
    end
  end


  resources :appointments
  resources :families

  
  get 'welcome/index', to: "welcome#index", as: "welcome"
  get 'home', to: 'home#index', as: 'home'


  devise_for :users
  
  # root to: "welcome#index"

  devise_scope :user do
    authenticated :user do
      root to: 'welcome#index', as: :user_authenticated_root
        resources :recipes 
    end
    unauthenticated :user do
      root :to => "welcome#index", as: :user_unauthenticated_root
    end   
  end

  devise_for :dietitians

  devise_scope :dietitian do
    authenticated :dietitian do
      get 'recipes/quick_update', to: 'recipes#quick_update', as: "quick_update"
      # root :to => 'recipes#dietitian_recipes_index', :constraints => lambda { |request| request.env['warden'].user.class.name == 'Dietitian' }, :as => "dietitian_authenticated_root"
      root :to => 'recipes#dietitian_recipes_index', as: :dietitian_authenticated_root
      resources :characteristics
      resources :ingredients_recipes do 
        get :autocomplete_ingredient_name, :on => :collection
      end
      resources :allergens_ingredients
      resources :recipes_patient_groups
      resources :recipe_steps do 
        collection { post :sort }
      end
      resources :allergens 
      resources :ingredients do 
        get :autocomplete_allergen_name, :on => :collection
        resources :quality_reviews
      end
      resources :articles do 
        resources :quality_reviews
        resources :marketing_items
      end
      resources :recipes do
        resources :quality_reviews
        resources :marketing_items

        get :autocomplete_ingredient_name, :on => :collection
      end
      # edit ingerdient allergens 
      get 'ingredients/edit_allergens/:id', to: 'ingredients#edit_allergens', as: "edit_allergens"
      patch 'ingredients/update_allergens/:id', to: 'ingredients#update_allergens', as: "update_allergens"
      # edit recipe patient groups
      get 'recipes/:id/edit_patient_groups', to: 'recipes#edit_patient_groups', as: "edit_patient_groups"
      patch 'recipes/:id/update_patient_groups', to: 'recipes#update_patient_groups', as: "update_patient_groups"
      # edit recipe categories
      get 'recipes/:id/edit_recipe_categories', to: 'recipes#edit_recipe_categories', as: "edit_recipe_categories"
      patch 'recipes/:id/update_recipe_categories', to: 'recipes#update_recipe_categories', as: "update_recipe_categories"
      # dietitian recipes index page
      get '/recipes/dietitian_recipes_index/:id', to: 'recipes#dietitian_recipes_index', as: 'dietitian_recipes'
      # review recipe
      get 'recipes/:id/review_recipe', to: 'recipes#review_recipe', as: 'review_recipe'
      get 'recipes/:id/complete_recipe', to: 'recipes#complete_recipe', as: 'complete_recipe'
    end
    unauthenticated :dietitian do
      root :to => "welcome#index", as: :dietitian_unauthenticated_root
    end   
  end
  






end
