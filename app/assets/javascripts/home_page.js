

var HomePage = {
	setLinks: function(){


		$("#about-kindrdfood-link").on("click", function(e){
			e.preventDefault();
			$("#menu-bar").toggleClass("hidden");
			$(".arrow-down, .arrow-left").toggleClass("arrow-down arrow-left")
		})
	}

}