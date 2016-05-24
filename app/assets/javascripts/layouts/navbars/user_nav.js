

Kindrdfood = Kindrdfood || {};


Kindrdfood.layouts = Kindrdfood.layouts || {};

Kindrdfood.layouts.navbars = {
  init: function(){

  	$(".mobile-menu-button button").on("click", function(e){
  		e.preventDefault();
  		var $button = $(this);
  		if ( $button.hasClass("collapsed") ) { 
        $("#sidebar-nav").addClass("sidebar-offcanvas").removeClass("sidebar-offcanvas-mini");
        // $(".main-content-container").addClass("col-xs-11 col-sm-10 col-xs-offset-1 col-sm-offset-2").removeClass("col-xs-6 col-xs-offset-6");
        $(this).removeClass("collapsed");
  		} else {
        $("#sidebar-nav").removeClass("sidebar-offcanvas").addClass("sidebar-offcanvas-mini");
        // $(".sidebar-offcanvas").removeClass("hidden-xs col-sm-2").addClass("col-xs-6");
        // $(".main-content-container").removeClass("col-xs-11 col-sm-10 col-xs-offset-1 col-sm-offset-2").addClass("col-xs-6 col-xs-offset-6");
        $(this).addClass("collapsed");
  		}
		})
  }
};