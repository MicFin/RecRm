	

// Families Controller JS

//= require welcome/add_nutrition
//= require welcome/add_family


	
$(document).ready(function() {


	// JS for welcome#add_nutrition
	Kindrdfood.welcome.addNutrition.addGroupButtons();

	// JS for welcome#add_family
	Kindrdfood.welcome.addFamily.createPregnancyLogic("simple_form");
	Kindrdfood.welcome.addFamily.validateFamilyMemberForm("simple_form", "#family-page");

});