

var HomePage = {
	setLinks: function(){
		$("#about-kindrdfood-link").on("click", function(e){
			e.preventDefault();
			$("#menu-bar").toggleClass("hidden-sm");
			$(".section-1-top .arrow-down, .section-1-top .arrow-left").toggleClass("arrow-down arrow-left")
		})
		$("#thanksModal").modal();
		$("#member-sign-in-button, #member-sign-in-link").on("click", function(e){
			e.preventDefault();
			$(".home-page-form").toggleClass("hidden");
			$(this).toggleClass("btn-success btn-active")
			$(this).toggleText("Members Sign In", "Sign Up Here");
		});
		var arrow_height = $(window).height() - ($(window).height() * 0.057)
		$(".section-1 .arrow-down.page-arrow").css("top", arrow_height +"px");
	}

}