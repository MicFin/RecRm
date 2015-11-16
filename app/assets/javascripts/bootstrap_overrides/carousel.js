
Kindrdfood = Kindrdfood || {};


Kindrdfood.bootstrapOverrides = Kindrdfood.bootstrapOverrides || {};

Kindrdfood.bootstrapOverrides.carousel = {
  init: function(){
  	var checkItem = function() {
  		var $this;
		  $this = $("#carousel-client-prep");
		  if ($("#carousel-client-prep .carousel-inner .item:first").hasClass("active")) {
		    $("a[data-slide='prev']").hide();
		    $("a[data-slide='next']").show();
		  } else if ($("#carousel-client-prep .carousel-inner .item:last").hasClass("active")) {
		   	$("a[data-slide='next']").hide();
		    $("a[data-slide='prev']").show();
		  } else {
		    $("a[data-slide='prev'], a[data-slide='next']").show();
		  }
  	}; 
		$('#carousel-client-prep').on('slid.bs.carousel', checkItem);
		checkItem();
  }
}