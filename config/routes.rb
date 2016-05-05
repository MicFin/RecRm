# == Route Map
#
#                                   Prefix Verb       URI Pattern                                                        Controller#Action
#            food_diary_food_diary_entries GET        /food_diaries/:food_diary_id/food_diary_entries(.:format)          food_diary_entries#index
#                                          POST       /food_diaries/:food_diary_id/food_diary_entries(.:format)          food_diary_entries#create
#          new_food_diary_food_diary_entry GET        /food_diaries/:food_diary_id/food_diary_entries/new(.:format)      food_diary_entries#new
#         edit_food_diary_food_diary_entry GET        /food_diaries/:food_diary_id/food_diary_entries/:id/edit(.:format) food_diary_entries#edit
#              food_diary_food_diary_entry GET        /food_diaries/:food_diary_id/food_diary_entries/:id(.:format)      food_diary_entries#show
#                                          PATCH      /food_diaries/:food_diary_id/food_diary_entries/:id(.:format)      food_diary_entries#update
#                                          PUT        /food_diaries/:food_diary_id/food_diary_entries/:id(.:format)      food_diary_entries#update
#                                          DELETE     /food_diaries/:food_diary_id/food_diary_entries/:id(.:format)      food_diary_entries#destroy
#                             food_diaries GET        /food_diaries(.:format)                                            food_diaries#index
#                                          POST       /food_diaries(.:format)                                            food_diaries#create
#                           new_food_diary GET        /food_diaries/new(.:format)                                        food_diaries#new
#                          edit_food_diary GET        /food_diaries/:id/edit(.:format)                                   food_diaries#edit
#                               food_diary GET        /food_diaries/:id(.:format)                                        food_diaries#show
#                                          PATCH      /food_diaries/:id(.:format)                                        food_diaries#update
#                                          PUT        /food_diaries/:id(.:format)                                        food_diaries#update
#                                          DELETE     /food_diaries/:id(.:format)                                        food_diaries#destroy
#              growth_chart_growth_entries GET        /growth_charts/:growth_chart_id/growth_entries(.:format)           growth_entries#index
#                                          POST       /growth_charts/:growth_chart_id/growth_entries(.:format)           growth_entries#create
#            new_growth_chart_growth_entry GET        /growth_charts/:growth_chart_id/growth_entries/new(.:format)       growth_entries#new
#           edit_growth_chart_growth_entry GET        /growth_charts/:growth_chart_id/growth_entries/:id/edit(.:format)  growth_entries#edit
#                growth_chart_growth_entry GET        /growth_charts/:growth_chart_id/growth_entries/:id(.:format)       growth_entries#show
#                                          PATCH      /growth_charts/:growth_chart_id/growth_entries/:id(.:format)       growth_entries#update
#                                          PUT        /growth_charts/:growth_chart_id/growth_entries/:id(.:format)       growth_entries#update
#                                          DELETE     /growth_charts/:growth_chart_id/growth_entries/:id(.:format)       growth_entries#destroy
#                            growth_charts GET        /growth_charts(.:format)                                           growth_charts#index
#                                          POST       /growth_charts(.:format)                                           growth_charts#create
#                         new_growth_chart GET        /growth_charts/new(.:format)                                       growth_charts#new
#                        edit_growth_chart GET        /growth_charts/:id/edit(.:format)                                  growth_charts#edit
#                             growth_chart GET        /growth_charts/:id(.:format)                                       growth_charts#show
#                                          PATCH      /growth_charts/:id(.:format)                                       growth_charts#update
#                                          PUT        /growth_charts/:id(.:format)                                       growth_charts#update
#                                          DELETE     /growth_charts/:id(.:format)                                       growth_charts#destroy
#                   survey_group_questions GET        /survey_groups/:survey_group_id/questions(.:format)                questions#index
#                                          POST       /survey_groups/:survey_group_id/questions(.:format)                questions#create
#                new_survey_group_question GET        /survey_groups/:survey_group_id/questions/new(.:format)            questions#new
#               edit_survey_group_question GET        /survey_groups/:survey_group_id/questions/:id/edit(.:format)       questions#edit
#                    survey_group_question GET        /survey_groups/:survey_group_id/questions/:id(.:format)            questions#show
#                                          PATCH      /survey_groups/:survey_group_id/questions/:id(.:format)            questions#update
#                                          PUT        /survey_groups/:survey_group_id/questions/:id(.:format)            questions#update
#                                          DELETE     /survey_groups/:survey_group_id/questions/:id(.:format)            questions#destroy
#                            survey_groups GET        /survey_groups(.:format)                                           survey_groups#index
#                                          POST       /survey_groups(.:format)                                           survey_groups#create
#                         new_survey_group GET        /survey_groups/new(.:format)                                       survey_groups#new
#                        edit_survey_group GET        /survey_groups/:id/edit(.:format)                                  survey_groups#edit
#                             survey_group GET        /survey_groups/:id(.:format)                                       survey_groups#show
#                                          PATCH      /survey_groups/:id(.:format)                                       survey_groups#update
#                                          PUT        /survey_groups/:id(.:format)                                       survey_groups#update
#                                          DELETE     /survey_groups/:id(.:format)                                       survey_groups#destroy
#                                 ckeditor            /ckeditor                                                          Ckeditor::Engine
#                                monologue            /education                                                         Monologue::Engine
#                   new_admin_user_session GET        /admin/login(.:format)                                             active_admin/devise/sessions#new
#                       admin_user_session POST       /admin/login(.:format)                                             active_admin/devise/sessions#create
#               destroy_admin_user_session DELETE|GET /admin/logout(.:format)                                            active_admin/devise/sessions#destroy
#                      admin_user_password POST       /admin/password(.:format)                                          active_admin/devise/passwords#create
#                  new_admin_user_password GET        /admin/password/new(.:format)                                      active_admin/devise/passwords#new
#                 edit_admin_user_password GET        /admin/password/edit(.:format)                                     active_admin/devise/passwords#edit
#                                          PATCH      /admin/password(.:format)                                          active_admin/devise/passwords#update
#                                          PUT        /admin/password(.:format)                                          active_admin/devise/passwords#update
#                               admin_root GET        /admin(.:format)                                                   admin/dashboard#index
#           batch_action_admin_admin_users POST       /admin/admin_users/batch_action(.:format)                          admin/admin_users#batch_action
#                        admin_admin_users GET        /admin/admin_users(.:format)                                       admin/admin_users#index
#                                          POST       /admin/admin_users(.:format)                                       admin/admin_users#create
#                     new_admin_admin_user GET        /admin/admin_users/new(.:format)                                   admin/admin_users#new
#                    edit_admin_admin_user GET        /admin/admin_users/:id/edit(.:format)                              admin/admin_users#edit
#                         admin_admin_user GET        /admin/admin_users/:id(.:format)                                   admin/admin_users#show
#                                          PATCH      /admin/admin_users/:id(.:format)                                   admin/admin_users#update
#                                          PUT        /admin/admin_users/:id(.:format)                                   admin/admin_users#update
#                                          DELETE     /admin/admin_users/:id(.:format)                                   admin/admin_users#destroy
#                          admin_dashboard GET        /admin/dashboard(.:format)                                         admin/dashboard#index
#            batch_action_admin_dietitians POST       /admin/dietitians/batch_action(.:format)                           admin/dietitians#batch_action
#                         admin_dietitians GET        /admin/dietitians(.:format)                                        admin/dietitians#index
#                                          POST       /admin/dietitians(.:format)                                        admin/dietitians#create
#                      new_admin_dietitian GET        /admin/dietitians/new(.:format)                                    admin/dietitians#new
#                     edit_admin_dietitian GET        /admin/dietitians/:id/edit(.:format)                               admin/dietitians#edit
#                          admin_dietitian GET        /admin/dietitians/:id(.:format)                                    admin/dietitians#show
#                                          PATCH      /admin/dietitians/:id(.:format)                                    admin/dietitians#update
#                                          PUT        /admin/dietitians/:id(.:format)                                    admin/dietitians#update
#                                          DELETE     /admin/dietitians/:id(.:format)                                    admin/dietitians#destroy
#          batch_action_admin_member_plans POST       /admin/member_plans/batch_action(.:format)                         admin/member_plans#batch_action
#                       admin_member_plans GET        /admin/member_plans(.:format)                                      admin/member_plans#index
#                                          POST       /admin/member_plans(.:format)                                      admin/member_plans#create
#                    new_admin_member_plan GET        /admin/member_plans/new(.:format)                                  admin/member_plans#new
#                   edit_admin_member_plan GET        /admin/member_plans/:id/edit(.:format)                             admin/member_plans#edit
#                        admin_member_plan GET        /admin/member_plans/:id(.:format)                                  admin/member_plans#show
#                                          PATCH      /admin/member_plans/:id(.:format)                                  admin/member_plans#update
#                                          PUT        /admin/member_plans/:id(.:format)                                  admin/member_plans#update
#                                          DELETE     /admin/member_plans/:id(.:format)                                  admin/member_plans#destroy
#        batch_action_admin_patient_groups POST       /admin/patient_groups/batch_action(.:format)                       admin/patient_groups#batch_action
#                     admin_patient_groups GET        /admin/patient_groups(.:format)                                    admin/patient_groups#index
#                                          POST       /admin/patient_groups(.:format)                                    admin/patient_groups#create
#                  new_admin_patient_group GET        /admin/patient_groups/new(.:format)                                admin/patient_groups#new
#                 edit_admin_patient_group GET        /admin/patient_groups/:id/edit(.:format)                           admin/patient_groups#edit
#                      admin_patient_group GET        /admin/patient_groups/:id(.:format)                                admin/patient_groups#show
#                                          PATCH      /admin/patient_groups/:id(.:format)                                admin/patient_groups#update
#                                          PUT        /admin/patient_groups/:id(.:format)                                admin/patient_groups#update
#                                          DELETE     /admin/patient_groups/:id(.:format)                                admin/patient_groups#destroy
#         batch_action_admin_subscriptions POST       /admin/subscriptions/batch_action(.:format)                        admin/subscriptions#batch_action
#                      admin_subscriptions GET        /admin/subscriptions(.:format)                                     admin/subscriptions#index
#                                          POST       /admin/subscriptions(.:format)                                     admin/subscriptions#create
#                   new_admin_subscription GET        /admin/subscriptions/new(.:format)                                 admin/subscriptions#new
#                  edit_admin_subscription GET        /admin/subscriptions/:id/edit(.:format)                            admin/subscriptions#edit
#                       admin_subscription GET        /admin/subscriptions/:id(.:format)                                 admin/subscriptions#show
#                                          PATCH      /admin/subscriptions/:id(.:format)                                 admin/subscriptions#update
#                                          PUT        /admin/subscriptions/:id(.:format)                                 admin/subscriptions#update
#                                          DELETE     /admin/subscriptions/:id(.:format)                                 admin/subscriptions#destroy
#                 batch_action_admin_users POST       /admin/users/batch_action(.:format)                                admin/users#batch_action
#                              admin_users GET        /admin/users(.:format)                                             admin/users#index
#                                          POST       /admin/users(.:format)                                             admin/users#create
#                           new_admin_user GET        /admin/users/new(.:format)                                         admin/users#new
#                          edit_admin_user GET        /admin/users/:id/edit(.:format)                                    admin/users#edit
#                               admin_user GET        /admin/users/:id(.:format)                                         admin/users#show
#                                          PATCH      /admin/users/:id(.:format)                                         admin/users#update
#                                          PUT        /admin/users/:id(.:format)                                         admin/users#update
#                                          DELETE     /admin/users/:id(.:format)                                         admin/users#destroy
#                           admin_comments GET        /admin/comments(.:format)                                          admin/comments#index
#                                          POST       /admin/comments(.:format)                                          admin/comments#create
#                            admin_comment GET        /admin/comments/:id(.:format)                                      admin/comments#show
#                      landing_pages_index GET        /landing_pages/index(.:format)                                     landing_pages#index
#                  landing_pages_qol_admin GET        /qoladmin(.:format)                                                landing_pages#qol_admin
#                        landing_pages_qol GET        /qol(.:format)                                                     landing_pages#qol
#                       landing_pages_tara GET        /tara(.:format)                                                    landing_pages#tara
#                                     join GET        /join(.:format)                                                    redirect(301, /tara)
#               landing_pages_our_solution GET        /our_solution(.:format)                                            landing_pages#our_solution
#                    landing_pages_results GET        /results(.:format)                                                 landing_pages#results
#               landing_pages_how_it_works GET        /how_it_works(.:format)                                            landing_pages#how_it_works
#                landing_pages_who_we_help GET        /who_we_help(.:format)                                             landing_pages#who_we_help
#             landing_pages_why_kindrdfood GET        /why_kindrdfood(.:format)                                          landing_pages#why_kindrdfood
#                    landing_pages_quality GET        /quality(.:format)                                                 landing_pages#quality
#            landing_pages_navigate_change GET        /navigate_change(.:format)                                         landing_pages#navigate_change
#                landing_pages_our_mission GET        /our_mission(.:format)                                             landing_pages#our_mission
#                 landing_pages_leadership GET        /leadership(.:format)                                              landing_pages#leadership
#                   landing_pages_benefits GET        /benefits(.:format)                                                landing_pages#benefits
#              landing_pages_more_benefits GET        /more_benefits(.:format)                                           landing_pages#more_benefits
#                       landing_pages_care GET        /care(.:format)                                                    landing_pages#care
#                 landing_pages_contact_us GET        /contact_us(.:format)                                              landing_pages#contact_us
#                      landing_pages_refer GET        /refer(.:format)                                                   landing_pages#refer
#                     make_package_payment POST       /packages/:package_id/purchases/:id/make_payment(.:format)         purchases#make_payment
#                        package_purchases GET        /packages/:package_id/purchases(.:format)                          purchases#index
#                                          POST       /packages/:package_id/purchases(.:format)                          purchases#create
#                     new_package_purchase GET        /packages/:package_id/purchases/new(.:format)                      purchases#new
#                    edit_package_purchase GET        /packages/:package_id/purchases/:id/edit(.:format)                 purchases#edit
#                         package_purchase GET        /packages/:package_id/purchases/:id(.:format)                      purchases#show
#                                          PATCH      /packages/:package_id/purchases/:id(.:format)                      purchases#update
#                                          PUT        /packages/:package_id/purchases/:id(.:format)                      purchases#update
#                                          DELETE     /packages/:package_id/purchases/:id(.:format)                      purchases#destroy
#                                 packages GET        /packages(.:format)                                                packages#index
#                                          POST       /packages(.:format)                                                packages#create
#                              new_package GET        /packages/new(.:format)                                            packages#new
#                             edit_package GET        /packages/:id/edit(.:format)                                       packages#edit
#                                  package GET        /packages/:id(.:format)                                            packages#show
#                                          PATCH      /packages/:id(.:format)                                            packages#update
#                                          PUT        /packages/:id(.:format)                                            packages#update
#                                          DELETE     /packages/:id(.:format)                                            packages#destroy
#                                    plans GET        /plans(.:format)                                                   plans#index
#                                          POST       /plans(.:format)                                                   plans#create
#                                 new_plan GET        /plans/new(.:format)                                               plans#new
#                                edit_plan GET        /plans/:id/edit(.:format)                                          plans#edit
#                                     plan GET        /plans/:id(.:format)                                               plans#show
#                                          PATCH      /plans/:id(.:format)                                               plans#update
#                                          PUT        /plans/:id(.:format)                                               plans#update
#                                          DELETE     /plans/:id(.:format)                                               plans#destroy
#                    redeem_coupon_coupons GET        /coupons/redeem_coupon(.:format)                                   coupons#redeem_coupon
#                    remove_coupon_coupons GET        /coupons/remove_coupon(.:format)                                   coupons#remove_coupon
#                                  coupons GET        /coupons(.:format)                                                 coupons#index
#                                          POST       /coupons(.:format)                                                 coupons#create
#                               new_coupon GET        /coupons/new(.:format)                                             coupons#new
#                              edit_coupon GET        /coupons/:id/edit(.:format)                                        coupons#edit
#                                   coupon GET        /coupons/:id(.:format)                                             coupons#show
#                                          PATCH      /coupons/:id(.:format)                                             coupons#update
#                                          PUT        /coupons/:id(.:format)                                             coupons#update
#                                          DELETE     /coupons/:id(.:format)                                             coupons#destroy
#                             provider3126 GET        /provider3126(.:format)                                            redirect(301, /)
#                             provider9172 GET        /provider9172(.:format)                                            redirect(301, /)
#                       kindrdnutritionist GET        /kindrdnutritionist(.:format)                                      redirect(301, /dietitians/sign_in)
#                                     krdn GET        /krdn(.:format)                                                    redirect(301, /dietitians/sign_in)
#                                     root GET        /                                                                  admin/dashboard#index
#                         new_user_session GET        /users/sign_in(.:format)                                           users/sessions#new
#                             user_session POST       /users/sign_in(.:format)                                           users/sessions#create
#                     destroy_user_session DELETE     /users/sign_out(.:format)                                          users/sessions#destroy
#                            user_password POST       /users/password(.:format)                                          devise/passwords#create
#                        new_user_password GET        /users/password/new(.:format)                                      devise/passwords#new
#                       edit_user_password GET        /users/password/edit(.:format)                                     devise/passwords#edit
#                                          PATCH      /users/password(.:format)                                          devise/passwords#update
#                                          PUT        /users/password(.:format)                                          devise/passwords#update
#                 cancel_user_registration GET        /users/cancel(.:format)                                            users/registrations#cancel
#                        user_registration POST       /users(.:format)                                                   users/registrations#create
#                    new_user_registration GET        /users/sign_up(.:format)                                           users/registrations#new
#                   edit_user_registration GET        /users/edit(.:format)                                              users/registrations#edit
#                                          PATCH      /users(.:format)                                                   users/registrations#update
#                                          PUT        /users(.:format)                                                   users/registrations#update
#                                          DELETE     /users(.:format)                                                   users/registrations#destroy
#                        user_confirmation POST       /users/confirmation(.:format)                                      users/confirmations#create
#                    new_user_confirmation GET        /users/confirmation/new(.:format)                                  users/confirmations#new
#                                          GET        /users/confirmation(.:format)                                      users/confirmations#show
#                   accept_user_invitation GET        /users/invitation/accept(.:format)                                 users/invitations#edit
#                   remove_user_invitation GET        /users/invitation/remove(.:format)                                 users/invitations#destroy
#                          user_invitation POST       /users/invitation(.:format)                                        users/invitations#create
#                      new_user_invitation GET        /users/invitation/new(.:format)                                    users/invitations#new
#                                          PATCH      /users/invitation(.:format)                                        users/invitations#update
#                                          PUT        /users/invitation(.:format)                                        users/invitations#update
#                           new_user_image GET        /users/:id/images/new(.:format)                                    images#new
#                              user_images GET        /users/:id/images/index(.:format)                                  images#index
#                        create_user_image POST       /users/:id/images/create(.:format)                                 images#create
#                               user_image PATCH      /users/:user_id/images/:id/update(.:format)                        images#update
#                          crop_user_image GET        /users/:user_id/images/:id/crop(.:format)                          images#crop
#                                  welcome GET        /welcome/index(.:format)                                           welcome#index
#                             welcome_home GET        /welcome/home(.:format)                                            welcome#home
#                      welcome_get_started GET        /welcome/get_started(.:format)                                     welcome#get_started
#                  user_authenticated_root GET        /                                                                  welcome#home
#                       welcome_add_family GET        /welcome/add_family(.:format)                                      welcome#add_family
#                     welcome_build_family PATCH      /welcome/build_family(/:id)(.:format)                              welcome#build_family
#                    welcome_add_nutrition GET        /welcome/add_nutrition(.:format)                                   welcome#add_nutrition
#                  welcome_build_nutrition PATCH      /welcome/build_nutrition(.:format)                                 welcome#build_nutrition
#                  welcome_add_preferences GET        /welcome/add_preferences(.:format)                                 welcome#add_preferences
#                welcome_build_preferences PATCH      /welcome/build_preferences(.:format)                               welcome#build_preferences
#                  welcome_set_appointment GET        /welcome/set_appointment(.:format)                                 welcome#set_appointment
#     users_registrations_update_time_zone PATCH      /registrations/update_time_zone(.:format)                          users/registrations#update_time_zone
# users_registrations_create_family_member POST       /registrations/create_family_member(.:format)                      users/registrations#create_family_member
#                     remove_family_member DELETE     /families/:id/remove_member/:member_id(.:format)                   families#remove_member
#              families_edit_family_member GET        /families/:id/edit_family_member/:member_id(.:format)              families#edit_family_member
#               families_new_family_member GET        /families/:id/new_family_member(.:format)                          families#new_family_member
#                                 families GET        /families(.:format)                                                families#index
#                                          POST       /families(.:format)                                                families#create
#                               new_family GET        /families/new(.:format)                                            families#new
#                              edit_family GET        /families/:id/edit(.:format)                                       families#edit
#                                   family GET        /families/:id(.:format)                                            families#show
#                                          PATCH      /families/:id(.:format)                                            families#update
#                                          PUT        /families/:id(.:format)                                            families#update
#                                          DELETE     /families/:id(.:format)                                            families#destroy
#          appointments_begin_registration GET        /appointments/begin_registration/:duration(.:format)               appointments#begin_registration
#                     purchase_appointment GET        /appointments/:id/purchase(.:format)                               appointments#purchase
#                              select_time GET        /appointments/:id/select_time(.:format)                            appointments#select_time
#           user_complete_appt_prep_survey GET        /appointments/:id/complete_appt_prep_survey(.:format)              appointments#complete_appt_prep_survey
#                     end_user_appointment GET        /appointments/:id/end_appointment(.:format)                        appointments#end_appointment
#            new_appointment_request_times GET        /appointments/new_appointment_request_times(.:format)              appointments#new_appointment_request_times
#         create_appointment_request_times POST       /appointments/create_appointment_request_times(.:format)           appointments#create_appointment_request_times
#           appointment_user_survey_update PATCH      /appointments/:appointment_id/surveys/:id(.:format)                surveys#update
#             appointments_update_duration PATCH      /appointments/:id/update_duration(.:format)                        appointments#update_duration
#                             make_payment POST       /appointments/:appointment_id/purchases/:id/make_payment(.:format) purchases#make_payment
#                  client_appointment_prep GET        /appointments/:id/client_appointment_prep(.:format)                appointments#client_appointment_prep
#                    appointment_purchases GET        /appointments/:appointment_id/purchases(.:format)                  purchases#index
#                                          POST       /appointments/:appointment_id/purchases(.:format)                  purchases#create
#                 new_appointment_purchase GET        /appointments/:appointment_id/purchases/new(.:format)              purchases#new
#                edit_appointment_purchase GET        /appointments/:appointment_id/purchases/:id/edit(.:format)         purchases#edit
#                     appointment_purchase GET        /appointments/:appointment_id/purchases/:id(.:format)              purchases#show
#                                          PATCH      /appointments/:appointment_id/purchases/:id(.:format)              purchases#update
#                                          PUT        /appointments/:appointment_id/purchases/:id(.:format)              purchases#update
#                                          DELETE     /appointments/:appointment_id/purchases/:id(.:format)              purchases#destroy
#                      appointment_surveys GET        /appointments/:appointment_id/surveys(.:format)                    surveys#index
#                                          POST       /appointments/:appointment_id/surveys(.:format)                    surveys#create
#                   new_appointment_survey GET        /appointments/:appointment_id/surveys/new(.:format)                surveys#new
#                  edit_appointment_survey GET        /appointments/:appointment_id/surveys/:id/edit(.:format)           surveys#edit
#                       appointment_survey GET        /appointments/:appointment_id/surveys/:id(.:format)                surveys#show
#                                          PATCH      /appointments/:appointment_id/surveys/:id(.:format)                surveys#update
#                                          PUT        /appointments/:appointment_id/surveys/:id(.:format)                surveys#update
#                                          DELETE     /appointments/:appointment_id/surveys/:id(.:format)                surveys#destroy
#                             appointments GET        /appointments(.:format)                                            appointments#index
#                                          POST       /appointments(.:format)                                            appointments#create
#                          new_appointment GET        /appointments/new(.:format)                                        appointments#new
#                         edit_appointment GET        /appointments/:id/edit(.:format)                                   appointments#edit
#                              appointment GET        /appointments/:id(.:format)                                        appointments#show
#                                          PATCH      /appointments/:id(.:format)                                        appointments#update
#                                          PUT        /appointments/:id(.:format)                                        appointments#update
#                                          DELETE     /appointments/:id(.:format)                                        appointments#destroy
#                          new_user_survey GET        /users/:user_id/surveys/new(.:format)                              surveys#new
#                              user_survey PATCH      /users/:user_id/surveys/:id(.:format)                              surveys#update
#                          in_session_room GET        /rooms/:id/in_session(.:format)                                    rooms#in_session
#                                    rooms GET        /rooms(.:format)                                                   rooms#index
#                                          POST       /rooms(.:format)                                                   rooms#create
#                            subscriptions GET        /subscriptions(.:format)                                           subscriptions#index
#                                          POST       /subscriptions(.:format)                                           subscriptions#create
#                         new_subscription GET        /subscriptions/new(.:format)                                       subscriptions#new
#                        edit_subscription GET        /subscriptions/:id/edit(.:format)                                  subscriptions#edit
#                             subscription GET        /subscriptions/:id(.:format)                                       subscriptions#show
#                                          PATCH      /subscriptions/:id(.:format)                                       subscriptions#update
#                                          PUT        /subscriptions/:id(.:format)                                       subscriptions#update
#                                          DELETE     /subscriptions/:id(.:format)                                       subscriptions#destroy
#                               time_slots GET        /time_slots(.:format)                                              time_slots#index
#                                          POST       /time_slots(.:format)                                              time_slots#create
#                            new_time_slot GET        /time_slots/new(.:format)                                          time_slots#new
#                           edit_time_slot GET        /time_slots/:id/edit(.:format)                                     time_slots#edit
#                                time_slot GET        /time_slots/:id(.:format)                                          time_slots#show
#                                          PATCH      /time_slots/:id(.:format)                                          time_slots#update
#                                          PUT        /time_slots/:id(.:format)                                          time_slots#update
#                                          DELETE     /time_slots/:id(.:format)                                          time_slots#destroy
#                 update_user_confirmation PATCH      /user/confirmation(.:format)                                       users/confirmations#update
#                    new_dietitian_session GET        /dietitians/sign_in(.:format)                                      devise/sessions#new
#                        dietitian_session POST       /dietitians/sign_in(.:format)                                      devise/sessions#create
#                destroy_dietitian_session DELETE     /dietitians/sign_out(.:format)                                     devise/sessions#destroy
#                       dietitian_password POST       /dietitians/password(.:format)                                     devise/passwords#create
#                   new_dietitian_password GET        /dietitians/password/new(.:format)                                 devise/passwords#new
#                  edit_dietitian_password GET        /dietitians/password/edit(.:format)                                devise/passwords#edit
#                                          PATCH      /dietitians/password(.:format)                                     devise/passwords#update
#                                          PUT        /dietitians/password(.:format)                                     devise/passwords#update
#            cancel_dietitian_registration GET        /dietitians/cancel(.:format)                                       dietitians/registrations#cancel
#                   dietitian_registration POST       /dietitians(.:format)                                              dietitians/registrations#create
#               new_dietitian_registration GET        /dietitians/sign_up(.:format)                                      dietitians/registrations#new
#              edit_dietitian_registration GET        /dietitians/edit(.:format)                                         dietitians/registrations#edit
#                                          PATCH      /dietitians(.:format)                                              dietitians/registrations#update
#                                          PUT        /dietitians(.:format)                                              dietitians/registrations#update
#                                          DELETE     /dietitians(.:format)                                              dietitians/registrations#destroy
#             dietitian_authenticated_root GET        /                                                                  welcome#index
#                         show_user_survey GET        /users/:user_id/surveys/show(.:format)                             surveys#show
#                      new_dietitian_image GET        /dietitans/:id/images/new(.:format)                                images#new
#                         dietitian_images GET        /dietitans/:id/images/index(.:format)                              images#index
#                   create_dietitian_image POST       /dietitans/:id/images/create(.:format)                             images#create
#                          dietitian_image PATCH      /dietitans/:dietitian_id/images/:id/update(.:format)               images#update
#                     crop_dietitian_image GET        /dietitans/:dietitian_id/images/:id/crop(.:format)                 images#crop
#      appointment_dietitian_survey_update PATCH      /appointments/:appointment_id/surveys/:id(.:format)                surveys#update
#                       appointment_review GET        /appointments/:id/appointment_review(.:format)                     appointments#appointment_review
#             dietitian_appointment_survey GET        /appointments/:appointment_id/surveys/:id(.:format)                surveys#show
#                         appointment_prep GET        /appointments/:id/appointment_prep(.:format)                       appointments#appointment_prep
#                end_dietitian_appointment GET        /appointments/:id/end_appointment(.:format)                        appointments#end_appointment
#                          edit_assessment GET        /appointments/:id/edit_assessment(.:format)                        appointments#edit_assessment
#                                          GET        /appointments/:appointment_id/surveys(.:format)                    surveys#index
#                                          POST       /appointments/:appointment_id/surveys(.:format)                    surveys#create
#                                          GET        /appointments/:appointment_id/surveys/new(.:format)                surveys#new
#                                          GET        /appointments/:appointment_id/surveys/:id/edit(.:format)           surveys#edit
#                                          GET        /appointments/:appointment_id/surveys/:id(.:format)                surveys#show
#                                          PATCH      /appointments/:appointment_id/surveys/:id(.:format)                surveys#update
#                                          PUT        /appointments/:appointment_id/surveys/:id(.:format)                surveys#update
#                                          DELETE     /appointments/:appointment_id/surveys/:id(.:format)                surveys#destroy
#                                          GET        /appointments(.:format)                                            appointments#index
#                                          POST       /appointments(.:format)                                            appointments#create
#                                          GET        /appointments/new(.:format)                                        appointments#new
#                                          GET        /appointments/:id/edit(.:format)                                   appointments#edit
#                                          GET        /appointments/:id(.:format)                                        appointments#show
#                                          PATCH      /appointments/:id(.:format)                                        appointments#update
#                                          PUT        /appointments/:id(.:format)                                        appointments#update
#                                          DELETE     /appointments/:id(.:format)                                        appointments#destroy
#                                dashboard GET        /dashboard/index(.:format)                                         dashboard#index
#                        roles_assignments GET        /roles/assignments(.:format)                                       roles#assignments
#                         edit_assignments GET        /roles/assignments/edit/:id(.:format)                              roles#edit_assignments
#                       update_assignments PATCH      /roles/assignments/update/:id(.:format)                            roles#update_assignments
#                                    roles GET        /roles(.:format)                                                   roles#index
#                                          POST       /roles(.:format)                                                   roles#create
#                                 new_role GET        /roles/new(.:format)                                               roles#new
#                                edit_role GET        /roles/:id/edit(.:format)                                          roles#edit
#                                     role GET        /roles/:id(.:format)                                               roles#show
#                                          PATCH      /roles/:id(.:format)                                               roles#update
#                                          PUT        /roles/:id(.:format)                                               roles#update
#                                          DELETE     /roles/:id(.:format)                                               roles#destroy
#                             member_plans GET        /member_plans(.:format)                                            member_plans#index
#                                          POST       /member_plans(.:format)                                            member_plans#create
#                          new_member_plan GET        /member_plans/new(.:format)                                        member_plans#new
#                         edit_member_plan GET        /member_plans/:id/edit(.:format)                                   member_plans#edit
#                              member_plan GET        /member_plans/:id(.:format)                                        member_plans#show
#                                          PATCH      /member_plans/:id(.:format)                                        member_plans#update
#                                          PUT        /member_plans/:id(.:format)                                        member_plans#update
#                                          DELETE     /member_plans/:id(.:format)                                        member_plans#destroy
#           create_from_existing_time_slot GET        /time_slots/:id/create_from_existing(.:format)                     time_slots#create_from_existing
#      create_time_slots_from_availability GET        /time_slots/create_from_availability(.:format)                     time_slots#create_from_availability
#                                          GET        /time_slots(.:format)                                              time_slots#index
#                                          POST       /time_slots(.:format)                                              time_slots#create
#                                          GET        /time_slots/new(.:format)                                          time_slots#new
#                                          GET        /time_slots/:id/edit(.:format)                                     time_slots#edit
#                                          GET        /time_slots/:id(.:format)                                          time_slots#show
#                                          PATCH      /time_slots/:id(.:format)                                          time_slots#update
#                                          PUT        /time_slots/:id(.:format)                                          time_slots#update
#                                          DELETE     /time_slots/:id(.:format)                                          time_slots#destroy
#                             set_schedule POST       /availabilities/set_schedule(.:format)                             availabilities#set_schedule
#                          update_schedule PATCH      /availabilities/update_schedule(.:format)                          availabilities#update_schedule
#                           availabilities GET        /availabilities(.:format)                                          availabilities#index
#                                          POST       /availabilities(.:format)                                          availabilities#create
#                         new_availability GET        /availabilities/new(.:format)                                      availabilities#new
#                        edit_availability GET        /availabilities/:id/edit(.:format)                                 availabilities#edit
#                             availability GET        /availabilities/:id(.:format)                                      availabilities#show
#                                          PATCH      /availabilities/:id(.:format)                                      availabilities#update
#                                          PUT        /availabilities/:id(.:format)                                      availabilities#update
#                                          DELETE     /availabilities/:id(.:format)                                      availabilities#destroy
#                in_session_dietitian_room GET        /rooms/:id/in_session(.:format)                                    rooms#in_session
#                                          GET        /rooms(.:format)                                                   rooms#index
#                                          POST       /rooms(.:format)                                                   rooms#create
#                        users_invitations GET        /users/invitations(.:format)                                       users/invitations#index
#           dietitian_unauthenticated_root GET        /                                                                  landing_pages#index
#                             rails_routes GET        /rails/routes(.:format)                                            sextant/routes#index
#                           sextant_engine            /sextant                                                           Sextant::Engine
#                                   stripe            /stripe                                                            Stripe::Engine
#
# Routes for Ckeditor::Engine:
#         pictures GET    /pictures(.:format)             ckeditor/pictures#index
#                  POST   /pictures(.:format)             ckeditor/pictures#create
#          picture DELETE /pictures/:id(.:format)         ckeditor/pictures#destroy
# attachment_files GET    /attachment_files(.:format)     ckeditor/attachment_files#index
#                  POST   /attachment_files(.:format)     ckeditor/attachment_files#create
#  attachment_file DELETE /attachment_files/:id(.:format) ckeditor/attachment_files#destroy
#
# Routes for Monologue::Engine:
#               root GET      /                                      monologue/posts#index
#         posts_page GET      /page/:page(.:format)                  monologue/posts#index
#               feed GET      /feed(.:format)                        monologue/posts#feed {:format=>:rss}
#          tags_page GET      /tags/:tag(.:format)                   monologue/tags#show
#              admin GET      /monologue(.:format)                   monologue/admin/posts#index
#       admin_logout GET      /monologue/logout(.:format)            monologue/admin/sessions#destroy
#        admin_login GET      /monologue/login(.:format)             monologue/admin/sessions#new
#     admin_sessions GET      /monologue/sessions(.:format)          monologue/admin/sessions#index
#                    POST     /monologue/sessions(.:format)          monologue/admin/sessions#create
#  new_admin_session GET      /monologue/sessions/new(.:format)      monologue/admin/sessions#new
# edit_admin_session GET      /monologue/sessions/:id/edit(.:format) monologue/admin/sessions#edit
#      admin_session GET      /monologue/sessions/:id(.:format)      monologue/admin/sessions#show
#                    PATCH    /monologue/sessions/:id(.:format)      monologue/admin/sessions#update
#                    PUT      /monologue/sessions/:id(.:format)      monologue/admin/sessions#update
#                    DELETE   /monologue/sessions/:id(.:format)      monologue/admin/sessions#destroy
#        admin_posts GET      /monologue/posts(.:format)             monologue/admin/posts#index
#                    POST     /monologue/posts(.:format)             monologue/admin/posts#create
#     new_admin_post GET      /monologue/posts/new(.:format)         monologue/admin/posts#new
#    edit_admin_post GET      /monologue/posts/:id/edit(.:format)    monologue/admin/posts#edit
#         admin_post GET      /monologue/posts/:id(.:format)         monologue/admin/posts#show
#                    PATCH    /monologue/posts/:id(.:format)         monologue/admin/posts#update
#                    PUT      /monologue/posts/:id(.:format)         monologue/admin/posts#update
#                    DELETE   /monologue/posts/:id(.:format)         monologue/admin/posts#destroy
#        admin_users GET      /monologue/users(.:format)             monologue/admin/users#index
#                    POST     /monologue/users(.:format)             monologue/admin/users#create
#     new_admin_user GET      /monologue/users/new(.:format)         monologue/admin/users#new
#    edit_admin_user GET      /monologue/users/:id/edit(.:format)    monologue/admin/users#edit
#         admin_user GET      /monologue/users/:id(.:format)         monologue/admin/users#show
#                    PATCH    /monologue/users/:id(.:format)         monologue/admin/users#update
#                    PUT      /monologue/users/:id(.:format)         monologue/admin/users#update
#                    DELETE   /monologue/users/:id(.:format)         monologue/admin/users#destroy
#     admin_comments GET      /monologue/comments(.:format)          monologue/admin/comments#show
# admin_post_preview PUT|POST /monologue/post/preview(.:format)      monologue/admin/posts#preview
#               post GET      /*post_url(.:format)                   monologue/posts#show
#
# Routes for Sextant::Engine:
#
#
# Routes for Stripe::Engine:
#   ping GET  /ping(.:format)   stripe/pings#show
# events POST /events(.:format) stripe/events#create
#

Rails.application.routes.draw do


  ### ROUTES FOR MONOLGUE
  mount Ckeditor::Engine => '/ckeditor'
  # or whatever path, be it "/blog" or "/monologue"
  mount Monologue::Engine, at: '/education' 
  Monologue::Engine.routes.draw do

    # # Not sure if need post_rec resources in engine as well as in main rails app
    # resources :post_recommendations

    namespace :admin, path: "monologue" do
      
      resources :tags
      
    end
  end


  ### ROUTES FOR ADMIN USERS
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
  patch 'packages/:package_id/purchases/:id/make_payment', to: 'purchases#make_payment', as: 'make_package_payment'
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

  resources :food_diaries do 
    resources :food_diary_entries
  end

  resources :growth_charts do 
     resources :growth_entries
  end

  resources :survey_groups do 
    resources :questions 
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
      get 'families/:id/show_family_member/:member_id', to: "families#show_family_member", as: 'families_show_family_member'
      resources :families

      # Appointments paths
      get 'appointments/:id/end_appointment', to: 'appointments#end_appointment', as: 'end_user_appointment'
      patch 'appointments/:appointment_id/surveys/:id', to: 'surveys#update', as: 'appointment_user_survey_update'
      patch 'appointments/:id/update_duration', to: "appointments#update_duration", as: "appointments_update_duration"
      patch 'appointments/:appointment_id/purchases/:id/make_payment', to: 'purchases#make_payment', as: 'make_payment'
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

      # # Post Recommendations, not sure what routes ill need
      # resources :post_recommendations
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
      
      # Families paths
      get 'families/:id/show_family_member/:member_id', to: "families#show_family_member", as: 'dietitian_show_family_member'
      get 'families/:id/', to: "families#show"

      # Appointment paths
      patch 'appointments/:appointment_id/surveys/:id', to: 'surveys#update', as: 'appointment_dietitian_survey_update'
      patch 'appointments/:id/assign_dietitian', to: 'appointments#assign_dietitian', as: 'appointments_assign_dietitian'
      get 'appointments/:appointment_id/surveys/:id', to: 'surveys#show', as: 'dietitian_appointment_survey'
      get 'appointments/:id/end_appointment', to: 'appointments#end_appointment', as: 'end_dietitian_appointment'
      patch "appointments/:id/send_assessment", to: "appointments#send_assessment", as: "appointment_send_assessment"
      resources :appointments do 
        resources :surveys
      end

      # Post Recommendation

      get "/post_recommendations/posts", to: "post_recommendations#posts", as: "post_recommendations_posts"
      resources :post_recommendations

      # Dashboard paths
      get 'dashboard/index', to: 'dashboard#index', as: 'dashboard'
      get 'dashboard/clients_onboarding', to: 'dashboard#clients_onboarding', as: 'dashboard_clients_onboarding'
      
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

    # # Post Recommendations, not sure which routes ill need
    # resources :post_recommendations

    # ROUTES FOR UNAUTHENTICATED DIETITIAN
    unauthenticated :dietitian do
      
      # THIS IS THE MAIN ROOT FOR ALL NON REGISTERED USERS
      root :to => "landing_pages#index", as: :dietitian_unauthenticated_root
    end   
  end
  

end
