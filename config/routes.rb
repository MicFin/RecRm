Rails.application.routes.draw do


  

  resources :food_diaries do 
    resources :food_diary_entries
  end

  
  resources :growth_charts do 
     resources :growth_entries
  end


  resources :survey_groups do 
    resources :questions 
  end

  mount Ckeditor::Engine => '/ckeditor'
  # or whatever path, be it "/blog" or "/monologue"
  mount Monologue::Engine, at: '/education' 
  


  devise_for :admin_users, ActiveAdmin::Devise.config
  
  ActiveAdmin.routes(self)

  ### ROUTES AVAILABLE TO NON USERS 
  get 'landing_pages/index', to: "landing_pages#index", as: "landing_pages_index"
  get 'qoladmin', to: "landing_pages#qol_admin", as: "landing_pages_qol_admin"
  get 'qol', to: "landing_pages#qol", as: "landing_pages_qol"
  get 'tara', to: 'landing_pages#tara', as: 'landing_pages_tara'
  get "/join" => redirect("/tara")
  
  # LANDING PAGES
  get 'our_solution', to: "landing_pages#our_solution", as: "landing_pages_our_solution"
  get 'results', to: "landing_pages#results", as: "landing_pages_results"
  get 'how_it_works', to: "landing_pages#how_it_works", as: "landing_pages_how_it_works"
  get 'who_we_help', to: "landing_pages#who_we_help", as: "landing_pages_who_we_help"
  get 'why_kindrdfood', to: "landing_pages#why_kindrdfood", as: "landing_pages_why_kindrdfood"
  get 'quality', to: "landing_pages#quality", as: "landing_pages_quality"
  get 'navigate_change', to: "landing_pages#navigate_change", as: "landing_pages_navigate_change"
  get 'our_mission', to: "landing_pages#our_mission", as: "landing_pages_our_mission"
  get 'leadership', to: "landing_pages#leadership", as: "landing_pages_leadership"
  get 'benefits', to: "landing_pages#benefits", as: "landing_pages_benefits"
  get 'more_benefits', to: "landing_pages#more_benefits", as: "landing_pages_more_benefits"
  get 'care', to: "landing_pages#care", as: "landing_pages_care"
  get 'contact_us', to: "landing_pages#contact_us", as: "landing_pages_contact_us"
  get 'refer', to: "landing_pages#refer", as: "landing_pages_refer"

  # should change these to not being opened to all users
  post 'packages/:package_id/purchases/:id/make_payment', to: 'purchases#make_payment', as: 'make_package_payment'
  resources :packages do 
    resources :purchases 
  end

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


    # Images paths
    get 'users/:id/images/new', to: 'images#new', as: 'new_user_image'
    get 'users/:id/images/index', to: 'images#index', as: 'user_images'
    post 'users/:id/images/create', to: 'images#create', as: 'create_user_image'
    patch 'users/:user_id/images/:id/update', to: 'images#update', as: 'user_image'
    get 'users/:user_id/images/:id/crop', to: 'images#crop', as: 'crop_user_image'
      
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
      patch 'welcome/build_family(/:id)', to: "welcome#build_family", as: "welcome_build_family"
      get 'welcome/add_nutrition', to: "welcome#add_nutrition", as: "welcome_add_nutrition"
      patch 'welcome/build_nutrition', to: "welcome#build_nutrition", as: "welcome_build_nutrition"
      get 'welcome/add_preferences', to: "welcome#add_preferences", as: "welcome_add_preferences"
      patch 'welcome/build_preferences', to: "welcome#build_preferences", as: "welcome_build_preferences"
      get 'welcome/set_appointment', to: "welcome#set_appointment", as: "welcome_set_appointment"

      # Registrations paths
      patch 'registrations/update_time_zone', to: "users/registrations#update_time_zone", as: "users_registrations_update_time_zone"
      post 'registrations/create_family_member', to: "users/registrations#create_family_member", as: "users_registrations_create_family_member"

      # Families paths
      delete 'families/:id/remove_member/:member_id', to: "families#remove_member", as: 'remove_family_member'
      get 'families/:id/edit_family_member/:member_id', to: "families#edit_family_member", as: 'families_edit_family_member'
      get 'families/:id/new_family_member', to: "families#new_family_member", as: 'families_new_family_member'
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
      post 'appointments/:appointment_id/purchases/:id/make_payment', to: 'purchases#make_payment', as: 'make_payment'
      get 'appointments/:id/client_appointment_prep', to: 'appointments#client_appointment_prep', as: 'client_appointment_prep'
      resources :appointments do 
        resources :purchases 
        resources :surveys
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
      get 'appointments/:appointment_id/surveys/:id', to: 'surveys#show', as: 'dietitian_appointment_survey'
      get 'appointments/:id/appointment_prep', to: 'appointments#appointment_prep', as: 'appointment_prep'
      get 'appointments/:id/end_appointment', to: 'appointments#end_appointment', as: 'end_dietitian_appointment'
      get '/appointments/:id/edit_assessment', to: 'appointments#edit_assessment', as: 'edit_assessment' 
      resources :appointments do 
        resources :surveys
      end

      # Role assignment paths
      get 'roles/assignments', to: 'roles#assignments', as: 'roles_assignments'
      get 'roles/assignments/edit/:id', to: 'roles#edit_assignments', as: 'edit_assignments'
      patch 'roles/assignments/update/:id', to: 'roles#update_assignments', as: 'update_assignments'
      resources :roles

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

      # Rooms paths
      match '/rooms/:id/in_session', :to => "rooms#in_session", :as => :in_session_dietitian_room, :via => :get
      resources :rooms, only: [:index, :create]
    end
    
      # Invitation paths
      get 'users/invitations', to: 'users/invitations#index', as: 'users_invitations'
      
    # ROUTES FOR UNAUTHENTICATED DIETITIAN
    unauthenticated :dietitian do
      
      # THIS IS THE MAIN ROOT FOR ALL NON REGISTERED USERS
      root :to => "landing_pages#index", as: :dietitian_unauthenticated_root
    end   
  end
  

end
