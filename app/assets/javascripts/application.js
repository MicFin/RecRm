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
// REMOVED NOT USED require jquery.ui.core
// REMOVED NOT USED require jquery.ui.widget
// REMOVED NOT USED require jquery.ui.mouse
// REMOVED NOT USED require jquery.ui.position
// REMOVED NOT USED require jquery.ui.slider
// REMOVED NOT USED require jquery.ui.autocomplete
// REMOVED NOT USED require jquery.ui.sortable
// REMOVED NOT USED require jquery.ui.draggable
// REMOVED NOT USED require jquery.ui.resizable

//  JQUERY PLUGINS
//= require plugins/jquery.Jcrop
//= require plugins/jquery-masked-input.min
//= require plugins/dirty_form_catcher
// REMOVED NOT USED require plugins/jquery-toggleText
// REMOVED NOT USED require plugins/remove_prefix_class

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

//  JAVASCRIPT TIME ZONES
//= require plugins/time_zones




// Namespace creation for all controller specific javascript
//= require kindrdfood


// Custom namespaced javascript for cross controller usage
// form_validations must come last because it uses datetimepicker and images 
//= require images/new_image
//= require datetimepickers/date_time_picker
//= require ajax_specific/ajax_update_url
//= require form_validations/growth_entries
//= require form_validations/food_diary_entries
//= require form_validations/family_member
//= require form_validations/surveys
//= require bootstrap_overrides/carousel

// BROWSER DETAILS FOR RAILS LOG
//= require browser_details


// CLEAN BELOW, MOVE OR IDEALLY REMOVE AS HTML CAN BE REMOVED

// Not needed on all controllers
//= require dietitian_edit_profile

// Not needed on all controllers
//= require availabilities

// Not needed on all controllers
//= require time_slots

// Not needed at all
//= require on_page_load

// Not needed on all controllers
//= require appointment

// Not needed on all controllers
//= require appointments_index

// Not needed on all controllers
//= require google_analytics