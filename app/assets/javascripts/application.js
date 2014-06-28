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
//= require_tree .



$(document).ready(function() {
	$("#js-add-ingredient-button").click(function(){
		// $("#ingredients-container").append("<div class='form-group ingredient'><%= recipe_form.fields_for :ingredients_recipes, @ingredients_recipe  do |ingredients_recipe_form| %><div class='form-group'><%= ingredients_recipe_form.input :amount %></div><div class='form-group'><%= ingredients_recipe_form.input :amount_unit %></div><div class='form-group'><%= ingredients_recipe_form.fields_for :ingredient, @ingredient do |ingredient_form| %><%= ingredient_form.input :name, :url => autocomplete_ingredient_name_recipes_path, :as => :autocomplete, input_html: {value: ingredient_form.object.name ||= nil} %><% end %></div><% end %></div>");
		 // $.ajax({
   //      url: "/ingredients/new",
   //      type: "get",
   //      data: dataString,
   //      success: function(data) {
   //          $("#main").append(data)
   //      }
   //  });
	
		// $("#ingredients-container").append("<%= escape_javascript(render( :partial => 'add_ingredient_form' )) %>");
	});

});