

Kindrdfood = Kindrdfood || {};


Kindrdfood.appointments = Kindrdfood.appointments || {};

Kindrdfood.appointments.appointmentPrep = {
  clientInit: function(){
  	// validate form
		Kindrdfood.formValidations.growthEntries.clientForm();
		// initiate carousel
		Kindrdfood.bootstrapOverrides.carousel.init();
		// initiate datetimepicker
		Kindrdfood.dateTimePickers.dateTimePicker.init();
	},
  dietitianInit: function(){
  	Kindrdfood.formValidations.growthEntries.dietitianForm();
	}
}