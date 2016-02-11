

Kindrdfood = Kindrdfood || {};


Kindrdfood.layouts = Kindrdfood.layouts || {};

Kindrdfood.layouts.navbars = {
  init: function(){

  	$(".left-nav-small button").on("click", function(e){
  		e.preventDefault();
  		var $button = $(this);
  		if ( $button.hasClass("collapsed") ) { 
  			$(".left-nav-mini").addClass("hidden-xs").removeClass("col-xs-12");
  			$(this).removeClass("collapsed");

  		} else {
  			$(".left-nav-mini").removeClass("hidden-xs").addClass("col-xs-12");
				$(this).addClass("collapsed");

  		}
		})
  }
};