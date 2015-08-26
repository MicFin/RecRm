Rails.application.routes.draw do


  devise_for :admin_users, ActiveAdmin::Devise.config
  
  ActiveAdmin.routes(self)

  ### ROUTES AVAILABLE TO NON USERS 
  get 'landing_pages/index', to: "landing_pages#index", as: "landing_pages_index"
  get 'qoladmin', to: "landing_pages#qol_admin", as: "landing_pages_qol_admin"
  get 'qol', to: "landing_pages#qol", as: "landing_pages_qol"
  get 'tara', to: 'landing_pages#tara', as: 'landing_pages_tara'
  get "/join" => redirect("/tara")

  # should change these to not being opened to all users
  resources :packages
  resources :purchases
  resources :plans 

  resources :coupons do 
    collection do 
      # /coupons/redeem_coupon
      get :redeem_coupon, to: 'coupons#redeem_coupon', as: 'redeem_coupon'
      # /coupons/remove_coupon
      get :remove_coupon, to: "coupons#remove_coupon", as: 'remove_coupon'
    end
  end




  # is it better to do a redirect or another route that goes to the same controller method?
  ### REDIRECTS
  get 'provider3126' => redirect("/")
  get 'provider9172' => redirect("/")
  get "/kindrdnutritionist" => redirect("/dietitians/sign_in")
  get "/krdn" => redirect("/dietitians/sign_in")


  ### ROUTES AVAILABLE TO ADMIN USERS 
  devise_scope :admin_user do
    authenticated :admin_user do 
      root to: "admin/dashboard#index"
    end
  end

  ### ROUTES AVAILABLE TO USERS 
  devise_for :users, :controllers => { :registrations => "users/registrations", sessions: 'users/sessions', :confirmations => "users/confirmations", :invitations => 'users/invitations' }

  devise_scope :user do

    # Routes available to all users not just authenticated
    get 'welcome/index', to: "welcome#index", as: "welcome"
    get 'welcome/home', to: "welcome#home", as: "welcome_home"
    get 'welcome/get_started', to: "welcome#get_started", as: "welcome_get_started"
    
    # Routes available to authenticated users
    authenticated :user do

      # Authenticated user root path
      root :to => 'welcome#home', as: :user_authenticated_root

      # Welcome controller paths
      get 'welcome/add_family', to: "welcome#add_family", as: "welcome_add_family"
      patch 'welcome/build_family', to: "welcome#build_family", as: "welcome_build_family"
      get 'welcome/add_nutrition', to: "welcome#add_nutrition", as: "welcome_add_nutrition"
      patch 'welcome/build_nutrition', to: "welcome#build_nutrition", as: "welcome_build_nutrition"
      get 'welcome/add_preferences', to: "welcome#add_preferences", as: "welcome_add_preferences"
      patch 'welcome/build_preferences', to: "welcome#build_preferences", as: "welcome_build_preferences"
      get 'welcome/set_appointment', to: "welcome#set_appointment", as: "welcome_set_appointment"

      # Dashboard controller paths
      get 'dashboard/home', to: 'dashboard#home', as: 'user_dashboard'

      # Registrations paths
      patch 'registrations/update_time_zone', to: "users/registrations#update_time_zone", as: "users_registrations_update_time_zone"

      # Families paths
      delete 'families/:id/remove_member/:member_id', to: "families#remove_member", as: 'remove_family_member'
      get 'families/:id/edit_family_member/:member_id', to: "families#edit_family_member", as: 'families_edit_family_member'
      resources :families

      # Appointments paths
      get '/appointments/begin_registration/:duration', to: "appointments#begin_registration", as: "appointments_begin_registration" 
      get 'appointments/:id/purchase', to: "appointments#purchase", as: "purchase_appointment"
      get 'appointments/:id/select_time', to: 'appointments#select_time', as: 'select_time'
      get 'appointments/:id/complete_appt_prep_survey', to: 'appointments#complete_appt_prep_survey', as: 'user_complete_appt_prep_survey'
      get 'appointments/:id/end_appointment', to: 'appointments#end_appointment', as: 'end_user_appointment'
      get 'appointments/new_appointment_request_times', to: 'appointments#new_appointment_request_times', as: 'new_appointment_request_times'
      post 'appointments/create_appointment_request_times', to: 'appointments#create_appointment_request_times', as: 'create_appointment_request_times'
      patch 'appointments/:appointment_id/surveys/:id', to: 'surveys#update', as: 'appointment_user_survey_update'
      patch 'appointments/:id/update_duration', to: "appointments#update_duration", as: "appointments_update_duration"
      resources :appointments do 
        resources :surveys do 
          resources :questions 
        end
      end

      # Surveys paths
      get 'users/:user_id/surveys/new', to: 'surveys#new', as: 'new_user_survey'
      patch 'users/:user_id/surveys/:id', to: 'surveys#update', as: 'user_survey'

      # Rooms paths
      match '/rooms/:id/in_session', :to => "rooms#in_session", :as => :in_session_room, :via => :get
      resources :rooms, only: [:index, :create]

      # Subscriptions paths
      resources :subscriptions

      # Time slots paths
      resources :time_slots

      # Recipes paths
      resources :recipes 

    end

    # ROUTES FOR UNCONFIRMED USERS
    unauthenticated :user do
      match '/user/confirmation' => 'users/confirmations#update', :via => :patch, :as => :update_user_confirmation
    end   

  end


  ### ROUTES AVAILABLE TO DIETITIANS 
  devise_for :dietitians, :controllers => { :registrations => "dietitians/registrations" }

  devise_scope :dietitian do

     # Routes available to authenticated dietitians
    authenticated :dietitian do

      # Authenticated dietitian root path
      root :to => 'welcome#index', as: :dietitian_authenticated_root

      # Survey paths
      get 'users/:user_id/surveys/show', to: 'surveys#show', as: 'show_user_survey'
      
      # Image paths
      get 'dietitans/:id/images/new', to: 'images#new', as: 'new_dietitian_image'
      get 'dietitans/:id/images/index', to: 'images#index', as: 'dietitian_images'
      post 'dietitans/:id/images/create', to: 'images#create', as: 'create_dietitian_image'
      patch 'dietitans/:dietitian_id/images/:id/update', to: 'images#update', as: 'dietitian_image'
      get 'dietitans/:dietitian_id/images/:id/crop', to: 'images#crop', as: 'crop_dietitian_image'
      
      # Appointment paths
      patch 'appointments/:appointment_id/surveys/:id', to: 'surveys#update', as: 'appointment_dietitian_survey_update'
      get 'appointments/:id/appointment_review', to: 'appointments#appointment_review', as: 'appointment_review'
      get 'appointments/:id/appointment_prep', to: 'appointments#appointment_prep', as: 'appointment_prep'
      get 'appointments/:id/end_appointment', to: 'appointments#end_appointment', as: 'end_dietitian_appointment'
      resources :appointments

      # Dashboard paths
      get 'dashboard/index', to: 'dashboard#index', as: 'dashboard'
      get 'dashboard/recipe_status', to: 'dashboard#recipe_status', as: 'dashboard_recipe_status'

      # Review conflict paths
      get 'review_conflicts/:id/select_reviewer', to: 'review_conflicts#select_reviewer', as: "select_reviewer"
      post 'review_conflicts/:id/assign_reviewer', to: 'review_conflicts#assign_reviewer', as: "assign_reviewer"
      get 'recipes/:recipe_id/review_conflicts/:id/start_review_conflict', to: 'review_conflicts#start_review_conflict', as: "start_review_conflict"
      patch 'recipes/:recipe_id/review_conflicts/:id/accept_review_conflict', to: 'review_conflicts#accept_review_conflict', as: "accept_review_conflict"
      patch 'recipes/:recipe_id/review_conflicts/:id/decline_review_conflict', to: 'review_conflicts#decline_review_conflict', as: "decline_review_conflict"
      patch 'recipes/:recipe_id/review_conflicts/:id/edit_review_conflict', to: 'review_conflicts#edit_review_conflict', as: "edit_review_conflict"

      # Role assignment paths
      get 'roles/assignments', to: 'roles#assignments', as: 'roles_assignments'
      get 'roles/assignments/edit/:id', to: 'roles#edit_assignments', as: 'edit_assignments'
      patch 'roles/assignments/update/:id', to: 'roles#update_assignments', as: 'update_assignments'
      resources :roles

      # Content quota paths
      resources :content_quotas
      get 'content_quotas/assign_content', to: 'content_quotas#assign_content', as: 'assign_content'  

      # Characteristic paths
      resources :characteristics

      # Member plans paths
      resources :member_plans

      # Time slot paths
      get 'time_slots/:id/create_from_existing', to: 'time_slots#create_from_existing', as: "create_from_existing_time_slot"
      get 'time_slots/create_from_availability', to: 'time_slots#create_from_availability', as: "create_time_slots_from_availability"
      resources :time_slots

      # Availabilities paths
      post 'availabilities/set_schedule', to: 'availabilities#set_schedule', as: "set_schedule"
      patch 'availabilities/update_schedule', to: 'availabilities#update_schedule', as: "update_schedule"
      resources :availabilities

      # Articles paths
      resources :articles do 
        resources :quality_reviews
        resources :marketing_items
      end
      
      # Recipes paths
      resources :recipes do
        resources :quality_reviews do 
          ### might not want to nest this deep
          resources :review_conflicts 
        end
        resources :marketing_items

        get :autocomplete_ingredient_name, :on => :collection
      end
      # Review recipe
      get 'recipes/:id/review_recipe', to: 'recipes#review_recipe', as: 'review_recipe'
      get 'recipes/:id/complete_recipe', to: 'recipes#complete_recipe', as: 'complete_recipe'
      # edit recipe categories
      get 'recipes/:id/edit_recipe_categories', to: 'recipes#edit_recipe_categories', as: "edit_recipe_categories"
      patch 'recipes/:id/update_recipe_categories', to: 'recipes#update_recipe_categories', as: "update_recipe_categories"
      # dietitian recipes index page
      get '/recipes/dietitian_recipes_index/:id', to: 'recipes#dietitian_recipes_index', as: 'dietitian_recipes'
      # edit recipe patient groups
      get 'recipes/:id/edit_patient_groups', to: 'recipes#edit_patient_groups', as: "edit_patient_groups"
      patch 'recipes/:id/update_patient_groups', to: 'recipes#update_patient_groups', as: "update_patient_groups"
      # Recipes quick update path
      get 'recipes/quick_update', to: 'recipes#quick_update', as: "quick_update"
      # Recipe data path
      get 'recipes/recipe_data', to: 'recipes#recipe_data', as: "recipe_data"
      # Quality review paths
      get 'recipes/:recipe_id/quality_reviews/:id/start_review', to: 'quality_reviews#start_review', as: "quality_reviews_start_review"
      # submits review to be completed and redirects to dashboard (should be PATCH?)
      get 'recipes/:recipe_id/quality_reviews/:id/complete_review', to: 'quality_reviews#complete_review', as: "quality_reviews_complete_review"
      # Recipes steps paths
      resources :recipe_steps do 
        collection { post :sort }
      end
      # Ingredients recipes paths
      resources :ingredients_recipes do 
        collection { post :sort }
        get :autocomplete_ingredient_name, :on => :collection
      end
      # Recipes patient groups paths
      resources :recipes_patient_groups

      # Ingredient paths
      resources :ingredients do 
        get :autocomplete_allergen_name, :on => :collection
        resources :quality_reviews
      end

      # Allergen paths
      # edit ingerdient allergens 
      get 'ingredients/edit_allergens/:id', to: 'ingredients#edit_allergens', as: "edit_allergens"
      patch 'ingredients/update_allergens/:id', to: 'ingredients#update_allergens', as: "update_allergens"
      resources :allergens 

      # Allergen ingredients paths
      resources :allergens_ingredients

      # Rooms paths
      match '/rooms/:id/in_session', :to => "rooms#in_session", :as => :in_session_dietitian_room, :via => :get
      resources :rooms, only: [:index, :create]
    end
    
    # ROUTES FOR UNAUTHENTICATED DIETITIAN
    unauthenticated :dietitian do
      
      # THIS IS THE MAIN ROOT FOR ALL NON REGISTERED USERS
      root :to => "landing_pages#index", as: :dietitian_unauthenticated_root
    end   
  end
  






end
