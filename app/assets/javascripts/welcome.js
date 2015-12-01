	

// Welcome Controller JS
//= require welcome/index
//= require welcome/get_started
//= require welcome/add_family
//= require welcome/add_nutrition
//= require welcome/set_appointment
//= require welcome/payment_modal

$(document).ready(function() {

	// JS for welcome#index
	Kindrdfood.welcome.index.init();

	// JS for welcome#get_started
	Kindrdfood.welcome.getStarted.init();

	// JS for welcome#add_family
	Kindrdfood.welcome.addFamily.init();

	// JS for welcome#add_nutrition
	Kindrdfood.welcome.addNutrition.init();

	// JS for welcome#set_appointment
	Kindrdfood.welcome.setAppointment.init();

});