
Kindrdfood = Kindrdfood || {};

Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.addNutrition = {

	init: function(){
	
		// input for patient groups and has a data-trigger of true
		$("input[data-triggers='true']").on("click", function(e){
	    if ( $("input[data-triggers='true']").is(":checked") ) {
	        $('.triggers-container').removeClass("hidden");
	    } 
	    else {
	        $('.triggers-container ').addClass("hidden");
	    }
		});
		Kindrdfood.formValidations.familyMembers.addGroupButtons();
	}


}    