// Controller specific JS to be executed for food diaries controller	

// Food Diaries Controller JS

//= require food_diaries/show
//= require food_diaries/new

	
$(document).ready(function() {

	Kindrdfood.foodDiaries.show.init();

	Kindrdfood.foodDiaries.new.init();

		// mobile nav
	Kindrdfood.layouts.navbars.init();
});