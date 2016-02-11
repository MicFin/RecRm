

Kindrdfood = Kindrdfood || {};


Kindrdfood.layouts = Kindrdfood.layouts || {};

Kindrdfood.layouts.navbars = {
  init: function(){

  	$(".mobile-menu-button button").on("click", function(e){
  		e.preventDefault();
  		var $button = $(this);
  		if ( $button.hasClass("collapsed") ) { 
        $(".left-nav-mini").addClass("hidden-xs col-xs-2").removeClass("left-nav-mini").addClass("left-nav-large");
        $(this).removeClass("collapsed");
  		} else {
        var $nav = $(".left-nav-large").removeClass("left-nav-large").addClass("left-nav-mini").removeClass("hidden-xs col-xs-2");
        $(this).addClass("collapsed");
  		}
		})
  }
};