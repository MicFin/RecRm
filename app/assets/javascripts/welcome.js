	

// Welcome Controller JS
//= require welcome/add_family
//= require welcome/add_nutrition
//= require welcome/get_started
//= require welcome/payment_modal
//= require welcome/index
	
$(document).ready(function() {

	// JS for welcome#add_family
	Kindrdfood.welcome.addFamily.init();

	// JS for welcome#add_nutrition
	Kindrdfood.welcome.addNutrition.init();

	// JS for welcome#get_started
	Kindrdfood.welcome.getStarted.init();

	// JS for welcome#index
	Kindrdfood.welcome.index.init();
});