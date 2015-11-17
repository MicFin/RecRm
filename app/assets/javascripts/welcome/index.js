
Kindrdfood = Kindrdfood || {};

Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.index = {

  init: function(){

	  $(".prep-appointment-button").on("click", function(e){
			e.preventDefault();
			var appointment_id = $(this).data("appt-id");

			$.ajax({
				type: "GET",
				datatype: "script",
				data: {},
				url: "/appointments/"+appointment_id+"/appointment_prep/",
				success: function(response){
					$(".family-member-health-container").css("min-height", function(){ 
	  				return $(window).height()-100;
					});

	       	// on family member view button click
	       	$(".family-member-health-preview").on("click", function(e){
	       		e.preventDefault();
	       		var family_member_id = $(this).data("family-member-id");
	       		$(".family-member-health-preview").removeClass("hidden");
	       		$(".family-member-health-container").addClass("hidden");
	       		$(".family-member").removeClass("selected-family-member");
	       		$("#family-member-"+family_member_id).addClass("selected-family-member");		
	       		$("#family-member-health-"+family_member_id).removeClass("hidden");
	         	$(".active-tab").removeClass("active-tab");
	         	$("#family-member-health-button").parent().addClass("active-tab");
	       	});
		    }
		  })
		});

		$(".appointment-review-button").on("click", function(e){
			e.preventDefault();
			var appointment_id = $(this).data("appt-id");

			$.ajax({
				type: "GET",
				datatype: "script",
				data: {},
				url: "/appointments/"+appointment_id+"/appointment_review/",
				success: function(response){
					$(".family-member-health-container").css("min-height", function(){ 
	  				return $(window).height()-100;
					});

	       	// on family member view button click
	       	$(".family-member-health-preview").on("click", function(e){
	       		e.preventDefault();
	       		var family_member_id = $(this).data("family-member-id");
	       		$(".family-member-health-preview").removeClass("hidden");
	       		$(".family-member-health-container").addClass("hidden");
	       		$(".family-member").removeClass("selected-family-member");
	       		$("#family-member-"+family_member_id).addClass("selected-family-member");		
	       		$("#family-member-health-"+family_member_id).removeClass("hidden");
	         	$(".active-tab").removeClass("active-tab");
	         	$("#family-member-health-button").parent().addClass("active-tab");
	       	});
		    }
		  })
		});
  	$(".reschedule-appointment").on("click", function(e){
  		e.preventDefault();
  		$("#rescheduleModal").modal("toggle");
  	})
  }
}