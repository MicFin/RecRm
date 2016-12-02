// Controller specific JS to be executed for appointments controller

//= require appointments/edit
//= require post_recommendations/posts 

// when page has loaded...
$(document).ready(function() {

	// mobile nav
	Kindrdfood.layouts.navbars.init();

	// appointments controller edit method js
	Kindrdfood.appointments.edit.init();
	// // JS for post_recommednations#posts
	// Kindrdfood.post_recommendations.posts.init();

});


