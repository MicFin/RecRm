

Kindrdfood = Kindrdfood || {};

// create landing pages object if not already created
Kindrdfood.landingPages = Kindrdfood.landingPages || {};

Kindrdfood.landingPages.main = {
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

		$(".js-register-provider").on("click", function(e){
			e.preventDefault();
			$("#provider-sign-up-modal").modal();
		})

		// meet the experts dietitian carousel
		var headshots = $(".head-shot-container");
		$(".carousel-container .carousel-controller").on("click", function(e){
			e.preventDefault();
			headshots.toggleClass("hidden");
		})

	}
}