
Kindrdfood = Kindrdfood || {};

Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.addNutrition = {

	init: function(){
	
		// input for patient groups and has a data-trigger of true
		$("#health-group-container").on("click", "input[name='user[patient_group_ids][]'][data-triggers='true']", function(e){
		
	    if ( $("input[name='user[patient_group_ids][]'][data-triggers='true']").is(":checked") ) {
	        $('.triggers-container').removeClass("hidden");
	    } 
	    else {
	        $('.triggers-container ').addClass("hidden");
	    }
		});
		Kindrdfood.formValidations.familyMembers.addGroupButtons();
	}


}    