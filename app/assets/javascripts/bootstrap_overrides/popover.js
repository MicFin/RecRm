
Kindrdfood = Kindrdfood || {};


Kindrdfood.bootstrapOverrides = Kindrdfood.bootstrapOverrides || {};

Kindrdfood.bootstrapOverrides.popOver = {
  init: function(){
  	
  	// close pop pup marker from anywhere
		$('html').click(function(e) {
		    $('span').popover('hide');
		});

		$('span').popover({
		    html: true,
		    trigger: 'manual'
		}).click(function(e) {
		    $(this).popover('toggle');
		    e.stopPropagation();
		});
  }
}