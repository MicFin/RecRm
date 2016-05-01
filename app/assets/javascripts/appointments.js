// Controller specific JS to be executed for appointments controller

//= require appointments/edit

// when page has loaded...
$(document).ready(function() {

	// mobile nav
	Kindrdfood.layouts.navbars.init();

	// appointments controller edit method js
	Kindrdfood.appointments.edit.init();
});


