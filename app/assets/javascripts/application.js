// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.autocomplete
//= require autocomplete-rails
//= require bootstrap
//= require turbolinks
//= require_self
//= require_tree .

$(document).ready(function() {
	// validate new recipe form with JS
  $("#new_recipe").validate({
    rules: {
      "recipe[name]":{
        required: true,
        minlength: 2
      },
      "recipe[characteristic_ids][]": {
        required: true
      }
    },
    messages: {
      "recipe[name]":{
        required: "Enter recipe name",
        minlength: "Must be at least 2 letters"
      },
      "recipe[characteristic_ids][]": {
        required: "Please select at least 1 of each Prep Time, Cook Time, Difficulty, Relevant Courses, and Relevant Age Groups."
      }
    },







  });

	// validate new ingredient form with JS: FAILING ****
  // i think it's due to the form being added in by JQuery so the validate listener isn't being attached (but I tried adding this to the new.js.erb and the create.js.erb so then it would be called after the form is inserted by JQuery and it didn't work either) or because form is remote true
  $("ingredients-recipe-form-validate").validate({
    rules: {
      "recipe[name]":{
        required: true,
        minlength: 2
      }
    },
    messages: {
      "recipe[name]":{
        required: "Enter recipe name",
        minlength: "Must be at least 2 letters"
      }
    }
  });
});