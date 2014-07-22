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
      # root :to => 'recipes#dietitian_recipes_index', :constraints => lambda { |request| request.env['warden'].user.class.name == 'Dietitian' }, :as => "dietitian_authenticated_root"
      root :to => 'recipes#dietitian_recipes_index', as: :dietitian_authenticated_root
      resources :characteristics
      resources :ingredients_recipes
      resources :allergens_ingredients
      resources :recipes_patient_groups
      resources :recipe_steps
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
      # dietitian recipes index page
      get '/recipes/dietitian_recipes_index/:id', to: 'recipes#dietitian_recipes_index', as: 'dietitian_recipes'
      # recipes edit recipe group page
      get '/recipes/edit_recipe_group/:id', to: 'recipes#edit_recipe_group', as: 'edit_recipe_group'
      get 'recipes/review_recipe/:id', to: 'recipes#review_recipe', as: 'review_recipe'
    end
    unauthenticated :dietitian do
      root :to => "welcome#index", as: :dietitian_unauthenticated_root
    end   
  end
  






end
