

var HomePage = {
	setLinks: function(){
		$("#about-kindrdfood-link").on("click", function(e){
			e.preventDefault();
			$("#menu-bar").toggleClass("hidden");
			$(".arrow-down, .arrow-left").toggleClass("arrow-down arrow-left")
		})
		$("#thanksModal").modal();
		$("#member-sign-in-button").on("click", function(e){
			e.preventDefault();
			$(".home-page-form").toggleClass("hidden");
			$(this).toggleClass("btn-success btn-active")
			$(this).toggleText("Members Sign In", "Sign Up Here");
		})
	}

}