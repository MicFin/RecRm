Rails.application.routes.draw do




  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_scope :admin_user do
    authenticated :admin_user do 
      root to: "admin/dashboard#index"
    end
  end




  get 'welcome/index', to: "welcome#index", as: "welcome"
  get 'welcome/home', to: "welcome#home", as: "welcome_home"
  get 'welcome/get_started', to: "welcome#get_started", as: "welcome_get_started"

  get 'landing_pages/index', to: "landing_pages#index", as: "landing_pages_index"
  get 'qol', to: "landing_pages#qol", as: "landing_pages_qol"


  resources :plans

  
  # get 'Ta10lI8839dAmi', to: 'home#index', as: 'main_landing_page'
  get 'Ta10lI8839dAmi', to: 'home#join', as: 'main_landing_page'
  get 'join', to: 'home#join', as: 'tara_landing_page'
  # get 'lI45StA00OdAMi', to: 'home#discount_landing_page', as: 'discount_landing_page'
  get 'home', to: 'home#home_page', as: 'home_page'
  # get 'provider3126', to: "home#provider3126", as: "provider3126"
  # get 'provider9172', to: "home#provider9172", as: "provider9172"
  get 'provider3126', to: "home#provider3126", as: "provider3126"
  get 'provider9172', to: "home#join", as: "provider9172"
  get "/kindrdnutritionist" => redirect("/dietitians/sign_in")


  devise_for :users, :controllers => { :registrations => "users/registrations", sessions: 'devise/sessions', :confirmations => "users/confirmations" }
  
  # # root to: "welcome#index"

  devise_scope :user do
    authenticated :user do
      # root :to => 'dashboard#home', as: :user_authenticated_root
      root :to => 'welcome#home', as: :user_authenticated_root
      get 'dashboard/home', to: 'dashboard#home', as: 'user_dashboard'

      # get 'registrations/new_user_intro/:id', to: 'users/registrations#new_user_intro', as: 'new_user_intro'

      get 'registrations/new_user_family/:id', to: 'users/registrations#new_user_family', as: 'new_user_family'
      get 'registrations/edit_user_health_groups/:id', to: 'users/registrations#edit_user_health_groups', as: 'edit_user_health_groups'
      # update health gorups
      patch 'registrations/update_user_health_groups/:id', to: 'users/registrations#update_user_health_groups', as: 'update_user_health_groups'
      get 'registrations/new_family_member/', to: 'users/registrations#new_family_member', as: 'new_family_member'
      post 'registrations/create_family_member', to: 'users/registrations#create_family_member', as: 'create_family_member'
      resources :time_slots
      resources :recipes 
      delete 'families/:id/remove_member/:member_id', to: "families#remove_member", as: 'remove_family_member'
      resources :families
      get 'appointments/:id/purchase', to: "appointments#purchase", as: "purchase_appointment"
      get 'appointments/:id/select_time', to: 'appointments#select_time', as: 'select_time'
      get 'appointments/:id/complete_appt_prep_survey', to: 'appointments#complete_appt_prep_survey', as: 'user_complete_appt_prep_survey'
      get 'appointments/:id/end_appointment', to: 'appointments#end_appointment', as: 'end_user_appointment'
      get 'appointments/new_appointment_request_times', to: 'appointments#new_appointment_request_times', as: 'new_appointment_request_times'
      post 'appointments/create_appointment_request_times', to: 'appointments#create_appointment_request_times', as: 'create_appointment_request_times'
      resources :appointments do 
        resources :surveys do 
          resources :questions 
        end
      end
      get 'users/:user_id/surveys/new', to: 'surveys#new', as: 'new_user_survey'
      patch 'users/:user_id/surveys/:id', to: 'surveys#update', as: 'user_survey'
      patch 'appointments/:appointment_id/surveys/:id', to: 'surveys#update', as: 'appointment_user_survey_update'
      resources :rooms, only: [:index, :create]
      match '/rooms/:id/in_session', :to => "rooms#in_session", :as => :in_session_room, :via => :get
      # resources :charges
      resources :subscriptions
    end
    unauthenticated :user do
      match '/user/confirmation' => 'users/confirmations#update', :via => :patch, :as => :update_user_confirmation
    end   

  end

  devise_for :dietitians, :controllers => { :registrations => "dietitians/registrations" }

  devise_scope :dietitian do
    authenticated :dietitian do
      root :to => 'welcome#index', as: :dietitian_authenticated_root
      resources :member_plans
      get 'users/:user_id/surveys/show', to: 'surveys#show', as: 'show_user_survey'
      patch 'appointments/:appointment_id/surveys/:id', to: 'surveys#update', as: 'appointment_dietitian_survey_update'
      get 'dietitans/:id/images/new', to: 'images#new', as: 'new_dietitian_image'
      get 'dietitans/:id/images/index', to: 'images#index', as: 'dietitian_images'
      post 'dietitans/:id/images/create', to: 'images#create', as: 'create_dietitian_image'
      patch 'dietitans/:dietitian_id/images/:id/update', to: 'images#update', as: 'dietitian_image'
      get 'dietitans/:dietitian_id/images/:id/crop', to: 'images#crop', as: 'crop_dietitian_image'
      get 'appointments/:id/appointment_review', to: 'appointments#appointment_review', as: 'appointment_review'
      get 'appointments/:id/appointment_prep', to: 'appointments#appointment_prep', as: 'appointment_prep'
      get 'appointments/:id/end_appointment', to: 'appointments#end_appointment', as: 'end_dietitian_appointment'
      resources :appointments
      get 'dashboard/index', to: 'dashboard#index', as: 'dashboard'
      get 'dashboard/recipe_status', to: 'dashboard#recipe_status', as: 'dashboard_recipe_status'
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
      post 'review_conflicts/:id/assign_reviewer', to: 'review_conflicts#assign_reviewer', as: "assign_reviewer"
      get 'recipes/:recipe_id/review_conflicts/:id/start_review_conflict', to: 'review_conflicts#start_review_conflict', as: "start_review_conflict"
      patch 'recipes/:recipe_id/review_conflicts/:id/accept_review_conflict', to: 'review_conflicts#accept_review_conflict', as: "accept_review_conflict"
      patch 'recipes/:recipe_id/review_conflicts/:id/decline_review_conflict', to: 'review_conflicts#decline_review_conflict', as: "decline_review_conflict"
      patch 'recipes/:recipe_id/review_conflicts/:id/edit_review_conflict', to: 'review_conflicts#edit_review_conflict', as: "edit_review_conflict"

      # root :to => 'recipes#dietitian_recipes_index', :constraints => lambda { |request| request.env['warden'].user.class.name == 'Dietitian' }, :as => "dietitian_authenticated_root"

      # role assignments index
      get 'roles/assignments', to: 'roles#assignments', as: 'roles_assignments'
      # role assignments
      get 'roles/assignments/edit/:id', to: 'roles#edit_assignments', as: 'edit_assignments'
      # role assignments
      patch 'roles/assignments/update/:id', to: 'roles#update_assignments', as: 'update_assignments'
      resources :roles
      get 'content_quotas/assign_content', to: 'content_quotas#assign_content', as: 'assign_content'  
      resources :content_quotas
      resources :characteristics
      get 'time_slots/:id/create_from_existing', to: 'time_slots#create_from_existing', as: "create_from_existing_time_slot"
      get 'time_slots/create_from_availability', to: 'time_slots#create_from_availability', as: "create_time_slots_from_availability"
      resources :time_slots
      post 'availabilities/set_schedule', to: 'availabilities#set_schedule', as: "set_schedule"
      patch 'availabilities/update_schedule', to: 'availabilities#update_schedule', as: "update_schedule"
      resources :availabilities
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
      resources :rooms, only: [:index, :create]
      match '/rooms/:id/in_session', :to => "rooms#in_session", :as => :in_session_dietitian_room, :via => :get
    end
    # unauthenticated :dietitian do
    #   root :to => "devise/sessions#new", as: :dietitian_unauthenticated_root
    # end   
    unauthenticated :dietitian do
      # root :to => "home#home_page", as: :dietitian_unauthenticated_root
      root :to => "home#join", as: :dietitian_unauthenticated_root
    end   
  end
  






end
