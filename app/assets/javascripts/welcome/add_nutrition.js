
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
		Kindrdfood.welcome.addNutrition.addGroupButtons();
	},

	addGroupButtons: function(){

		$("#addNutritionModel, #family-page").on("click", "#add-disease-button", function(e){
			$("#add-disease-form").removeClass("hidden");
			$(this).addClass("hidden");
		});
		$("#addNutritionModel, #family-page").on("click", "#new-health-group-button", function(e){
      e.preventDefault();
      var group_name = $("#new-health-group-field").val();
      var group_type = $("#new-health-group-field").attr("data-group-type");
      $("#add-disease-button").before(
      	'<span><input name="new_health_groups['+group_type+'][]" type="checkbox" value="' + group_name + '" checked><label class="collection_check_boxes">'+ group_name+'</label></span>');
      $("#new-health-group-field").val("");
      $("#add-disease-form").addClass("hidden");
      $("#add-disease-button").removeClass("hidden");
    });
		$("#addNutritionModel, #family-page").on("click", "#new-allergy-group-button", function(e){
      e.preventDefault();
      var group_name = $("#add-allergy-field").val();
      var group_type = $("#add-allergy-field").data("group-type");
      $("#add-allergy-container").before(
        '<div class="col-xs-6 col-sm-4 form-group">' +
					'<input id="user_patient_group_ids_' + group_name+'" name="new_health_groups['+group_type+'][]" type="checkbox" value="' + group_name+'" checked>' +
					'<label class="checkbox-inline" for="user_patient_group_ids_' + group_name+'">'+group_name +
					'</label>' +
				'</div>');
      $("#add-allergy-field").val("");
    });

	}


}    