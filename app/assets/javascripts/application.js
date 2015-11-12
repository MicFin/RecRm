// This is a manifest file that'll be compiled into application.js, which will include all the files listed below. Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts, or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.  It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the compiled file. Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets/directives) for details about supported directives.

//////////////////////////////////////////////////////////////////////////////
// 																																				  //
// 			SITE WIDE REQUIREMENTS are listed below 								 						//
//																																					//
//			controller specific javascript requirements 												//
//			are in the controller_name.js files 																//
//																																					//
//////////////////////////////////////////////////////////////////////////////


//  SOME OF THESE COULD BE MOVED TO CONTROLLER SPECIFIC REQUIREMENTS

//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require jquery.ui.core
//= require jquery.ui.widget
//= require jquery.ui.mouse
//= require jquery.ui.position
//= require jquery.ui.slider
//= require jquery.ui.autocomplete
//= require jquery.ui.sortable
//= require jquery.ui.draggable
//= require jquery.ui.resizable

//= require plugins/jquery.Jcrop
//= require plugins/jquery-toggleText
//= require plugins/remove_prefix_class
//= require plugins/jquery-masked-input.min

//= require moment

//= require bootstrap

//= require bootstrap-datetimepicker

//= require plugins/bootstrap-tour-min

//= require fullcalendar

//= require plugins/jquery-validate.min.js
//= require plugins/jquery-validate-extra-methods.min.js

//= require plugins/smooth_scroll

// REMOVED require plugins/skrollr.min.js

//= require plugins/time_zones

// Namespace creation for all controller specific javascript
//= require kindrdfood


// Custom namespaced javascript for cross controller usage
//= require form_validations/growth_entries
//= require datetimepickers/date_time_picker

// Browser Specific JS
//= require browser_details





// CLEAN BELOW, MOVE OR IDEALLY REMOVE AS HTML CAN BE REMOVED

//= require new_recipe_bread_crumb
//= require health_groups_and_categories_preview
//= require dietitian_nav
//= require dietitian_edit_profile
//= require recipe_step_list
//= require override_bootstrap
//= require user_sign_up
//= require form_validations
//= require availabilities
//= require time_slots
//= require on_page_load
//= require appointment
//= require appointments_index
//= require tok_box_main.js
//= require images
//= require google_analytics
//= require home_page

//= require basic_form_validate




