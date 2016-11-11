// Controller specific JS to be executed for landing pages controller

// Landing Pages Controller JS
//= require landing_pages/qol_admin
//= require landing_pages/index

// when page has loaded...
$(document).ready(function() {

	// // use smooth scroll
	// SmoothScroll.start();	

	// JS for landing_pages#qoladmin
	Kindrdfood.landingPages.qolAdmin.validateSignUpForm();
	Kindrdfood.landingPages.qolAdmin.validateSignInForm();

	// // JS for landing_pages#index
	Kindrdfood.landingPages.main.init();
});