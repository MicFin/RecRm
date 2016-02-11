
Kindrdfood = Kindrdfood || {};


Kindrdfood.bootstrapOverrides = Kindrdfood.bootstrapOverrides || {};

Kindrdfood.bootstrapOverrides.carousel = {
  init: function(){
  	var checkItem = function() {
  		var prepPosition = $(".item.active").data("prep-position");

		  if (prepPosition === "growth-chart") {
		    $("a[data-slide='prev']").addClass("hidden");
		    $("a[data-slide='next']").removeClass("hidden");
		  } else if (prepPosition === "survey")  {
		   	$("a[data-slide='next']").addClass("hidden");
		    $("a[data-slide='prev']").removeClass("hidden");
		  } else {
		    $("a[data-slide='prev'], a[data-slide='next']").removeClass("hidden");
		  }
  	}; 
		$('#carousel-client-prep').on('slid.bs.carousel', checkItem);
		checkItem();
  }
}