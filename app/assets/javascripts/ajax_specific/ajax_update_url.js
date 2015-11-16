
Kindrdfood = Kindrdfood || {};


Kindrdfood.ajaxSpecific = Kindrdfood.ajaxSpecific || {};

Kindrdfood.ajaxSpecific.ajaxUpdateUrl = {

	init: function(){
	  $(document).on('click', 'a[data-remote=true]', function(e) {
	    history.pushState({}, '', $(this).attr('href'));
	  });
	  $(window).on('popstate', function () {
	    $.get(document.location.href)
	  });
	}
};
