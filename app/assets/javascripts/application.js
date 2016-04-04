// This is a manifest file that'll be compiled into application.js, which will include all the files listed below. Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts, or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.  It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the compiled file. Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets/directives) for details about supported directives.

//////////////////////////////////////////////////////////////////////////////
// 																																				  //
// 			SITE WIDE REQUIREMENTS are listed below 								 						//
//																																					//
//			controller specific javascript requirements 												//
//			are in the controller_name.js files 																//
//																																					//
//////////////////////////////////////////////////////////////////////////////


//  JQUERY
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require jquery.turbolinks

//  JQUERY PLUGINS
//= require plugins/jquery.Jcrop
//= require plugins/jquery-masked-input.min
//= require plugins/dirty_form_catcher


//  JAVASCRIPT TIME AND DATES
//= require moment

//  BOOTSTRAP
//= require bootstrap

//  BOOTSTRAP PLUGINS
//= require bootstrap-datetimepicker
//= require plugins/bootstrap-tour-min

//  JQUERY CALENDAR
//= require fullcalendar

//  JQUERY VALIDATION
//= require plugins/jquery-validate.min.js
//= require plugins/jquery-validate-extra-methods.min.js
//= require plugins/jqueryValidateAddedMethods/minimum_age

//  JAVASCRIPT TIME ZONES
//= require plugins/time_zones

//  JAVASCRIPT COUNT DOWN
//= require plugins/count-down-clock.js

// BROWSER DETAILS FOR RAILS LOG
//= require browser_details

// NAMESPACE creation for all controller specific javascript
//= require kindrdfood

// CUSTOM namespaced javascript for cross controller usage
//= require images/new_image
//= require datetimepickers/date_time_picker
//= require ajax_specific/ajax_update_url
//= require bootstrap_overrides/carousel
//= require bootstrap_overrides/popover

// CUSTOM namespaced form validations (must come after datetimepickers and images)
//= require form_validations/growth_entries
//= require form_validations/food_diary_entries
//= require form_validations/family_member
//= require form_validations/surveys

// CUSTOM namespced javascript for layouts 
//= require layouts/navbars/user_nav

// STRIPE maybe not needed on all controllers
//= require plugins/payment

// GOOGLE ANALYTICS maybe not needed on all controllers
//= require google_analytics

/// CONTROLLER SPECIFIC JAVASCRIPT IS COMPILED IN ASSETS.RB
