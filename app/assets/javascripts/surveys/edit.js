

Kindrdfood = Kindrdfood || {};

Kindrdfood.surveys = Kindrdfood.surveys || {};

Kindrdfood.surveys.edit = {

	init: function(){
	  var groupName = $("#survey-questions-container").data("survey-group");
	  if (groupName === "Client - Pre Appointment" ){ 

			// validate forms
			Kindrdfood.formValidations.growthEntries.clientForm();
			Kindrdfood.formValidations.foodDiaryEntries.init();
			Kindrdfood.formValidations.surveys.openResponse();

			// initiate datetimepicker
			Kindrdfood.dateTimePickers.dateTimePicker.init();

		} else if (groupName ===  "Dietitian - Pre Appointment" ){ 
			 Kindrdfood.formValidations.growthEntries.dietitianForm();
		}
	}
}	