

Kindrdfood = Kindrdfood || {};

// create landing pages object if not already created
Kindrdfood.landingPages = Kindrdfood.landingPages || {};

Kindrdfood.landingPages.signUpForm = {
  init: function(){

		$(".sign-up-button").on("click", function(e){
			e.preventDefault();
			$("#sign-up-modal").modal();
		})

		$(".terms-modal-link").on("click", function(e){
			e.preventDefault();
			$("#terms-modal").modal();
		})
		
		$(".privacy-modal-link").on("click", function(e){
			e.preventDefault();
			$("#privacy-modal").modal();
		})
		// // use Skrollr
		// var s = skrollr.init();
	}
}