

Kindrdfood = Kindrdfood || {};

Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.home = {

  init: function(){
		$(".contact-us-link").on("click", function(e ){
			e.preventDefault();
			$("#contactUsModal").modal();
		})
	}
}
