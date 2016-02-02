
Kindrdfood = Kindrdfood || {};

Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.index = {

  init: function(){
  	$(".reschedule-appointment").on("click", function(e){
  		e.preventDefault();
  		$("#rescheduleModal").modal("toggle");
  	})
  }
}