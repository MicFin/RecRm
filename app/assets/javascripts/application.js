// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets/directives) for details
// about supported directives.
//
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

//= require moment
//= require bootstrap
//= require bootstrap-datetimepicker
//= require fullcalendar


//= require new_recipe_bread_crumb
//= require health_groups_and_categories_preview
//= require dietitian_nav
//= require articles_form
//= require recipe_step_list
//= require basic_form_validate
//= require override_bootstrap
//= require user_sign_up
//= require form_validations
//= require time_slots
//= require user_session
//= require on_page_load

var videos = 1;
var publisherObj;

var subscriberObj = {};

var MAX_WIDTH_VIDEO = 264;
var MAX_HEIGHT_VIDEO = 198;

// var MAX_WIDTH_VIDEO = 528;
// var MAX_HEIGHT_VIDEO = 396;

var MIN_WIDTH_VIDEO = 200;
var MIN_HEIGHT_VIDEO = 150;

var MAX_WIDTH_BOX = 800;
var MAX_HEIGHT_BOX = 600;

// var MAX_WIDTH_BOX = 1600;
// var MAX_HEIGHT_BOX = 1200;

var CURRENT_WIDTH = MAX_WIDTH_VIDEO;
var CURRENT_HEIGHT = MAX_HEIGHT_VIDEO;

function layoutManager() {
  var estBoxWidth = MAX_WIDTH_BOX / videos;
  var width = Math.min(MAX_WIDTH_VIDEO, Math.max(MIN_WIDTH_VIDEO,
        estBoxWidth));
  var height = 3*width/4;

  publisherObj.height = height;
  publisherObj.width = width;

  for(var subscriberDiv in subscriberObj) {
    subscriberDiv.height = height;
    subscriberDiv.width = width;
  }

  CURRENT_HEIGHT = height;
  CURRENT_WIDTH = width;
}



