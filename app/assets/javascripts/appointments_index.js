var AppointmentsIndex = {
	setButtons: function(){
		$(".show-family-button").on("click", function(e){
			e.preventDefault();
			var appt_id = $(this).closest(".appt-id").data("appt-id");
			$.ajax({
				type: "GET",
				datatype: "script",
				data: {},
				url: "/appointments/"+appt_id,
				success: function(response){
				} 
			})
		})
	}
}