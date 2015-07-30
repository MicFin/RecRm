// Controller specific JS to be executed for landing pages controller

// when page has loaded...
$(document).ready(function() {

	// use smooth scroll
	SmoothScroll.start();	

	// JS for landing_pages#qoladmin
	Kindrdfood.landingPages.qolAdmin.validateSignUpForm();
	Kindrdfood.landingPages.qolAdmin.validateSignInForm();

});