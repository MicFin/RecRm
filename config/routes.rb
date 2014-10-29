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
  
  # # root to: "welcome#index"

  devise_scope :user do
    authenticated :user do
      root to: 'welcome#index', as: :user_authenticated_root
        resources :recipes 
      resources :families
      resources :appointments
      resources :rooms
      match '/session/:id', :to => "rooms#session", :as => :party, :via => :get
    end
    # unauthenticated :user do
    #   root :to => "devise/sessions#new", as: :user_unauthenticated_root
    # end   
  end

  devise_for :dietitians

  devise_scope :dietitian do
    authenticated :dietitian do
      # start review
      get 'recipes/:recipe_id/quality_reviews/:id/start_review', to: 'quality_reviews#start_review', as: "quality_reviews_start_review"
      # submits review to be completed and redirects to dashboard (should be PATCH?)
      get 'recipes/:recipe_id/quality_reviews/:id/complete_review', to: 'quality_reviews#complete_review', as: "quality_reviews_complete_review"
      # quick update deprecated?
      get 'recipes/quick_update', to: 'recipes#quick_update', as: "quick_update"
      # recipe data
      get 'recipes/recipe_data', to: 'recipes#recipe_data', as: "recipe_data"
      # assining reivewer to review conflict
      get 'review_conflicts/:id/select_reviewer', to: 'review_conflicts#select_reviewer', as: "select_reviewer"
      patch 'review_conflicts/:id/assign_reviewer', to: 'review_conflicts#assign_reviewer', as: "assign_reviewer"
      get 'recipes/:recipe_id/review_conflicts/:id/start_review_conflict', to: 'review_conflicts#start_review_conflict', as: "start_review_conflict"
      patch 'recipes/:recipe_id/review_conflicts/:id/accept_review_conflict', to: 'review_conflicts#accept_review_conflict', as: "accept_review_conflict"
      patch 'recipes/:recipe_id/review_conflicts/:id/decline_review_conflict', to: 'review_conflicts#decline_review_conflict', as: "decline_review_conflict"
      patch 'recipes/:recipe_id/review_conflicts/:id/edit_review_conflict', to: 'review_conflicts#edit_review_conflict', as: "edit_review_conflict"
      # root :to => 'recipes#dietitian_recipes_index', :constraints => lambda { |request| request.env['warden'].user.class.name == 'Dietitian' }, :as => "dietitian_authenticated_root"
      root :to => 'welcome#index', as: :dietitian_authenticated_root
      resources :characteristics
      resources :ingredients_recipes do 
        collection { post :sort }
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
        resources :quality_reviews do 
          ### might not want to nest this deep
          resources :review_conflicts 
        end
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
      root :to => "devise/sessions#new", as: :dietitian_unauthenticated_root
    end   
  end
  






end
