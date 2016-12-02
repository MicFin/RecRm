

Kindrdfood = Kindrdfood || {};

Kindrdfood.appointments = Kindrdfood.appointments || {};

Kindrdfood.appointments.edit = {

	init: function(){

		// initiate datetimepicker
		Kindrdfood.dateTimePickers.dateTimePicker.init();

				// 
		$('#appointment_appointment_host_id').on("change", function(event){

			var familyId = $(this).find(":selected").data("family-id");

			$("#appointment_patient_focus_id option").each(function() {  

				if ( $(this).data("family-id") != familyId ) { 
					$(this).addClass("hidden");
				} else { 
					$(this).removeClass("hidden");
				}
			})
			$("#appointment_patient_focus_id option").not(".hidden").first().prop('selected', true);
		})
	}
}	