// Controller specific JS to be executed for dietitians controller

//= require dietitians/edit
//= require dietitians/index

// when page has loaded...
$(document).ready(function() {

	// JS for land
	Kindrdfood.dietitians.edit.init();

	Kindrdfood.dietitians.index.init();

});