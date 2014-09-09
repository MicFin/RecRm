$(document).ready(function() {

  //hover for feedback and help
  $('.always-hover').tooltip({trigger: 'manual'}).tooltip('show');
  $('.always-hover').on('click',function(){$(this).tooltip('destroy');});

  // change nav highlight to recipes 
  var pathname = window.location.pathname;
  if (pathname === "/recipes/new"){
  	$("#kindrd-navbar li").removeClass("active");
		$("#navbar-recipes").addClass("active");
	};

});