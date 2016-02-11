// Controller specific JS to be executed for appointments controller

//= require appointments/appointment_prep

// when page has loaded...
$(document).ready(function() {

	// JS for appointments#appointment_prep
	Kindrdfood.appointments.appointmentPrep.dietitianInit();

	Kindrdfood.appointments.appointmentPrep.clientInit();
	// mobile nav
	Kindrdfood.layouts.navbars.init();
});


