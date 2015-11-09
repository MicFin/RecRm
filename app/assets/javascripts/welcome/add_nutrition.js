
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
      var group_name = $(this).siblings().first().val();
      var group_type = $(this).siblings().first().attr("data-group-type");
   
      $(this).siblings().first().val("");
      if ( $("#add-disease-button").length >= 1){
      	$(this).parent().prev().before(
      	'<span><input name="new_health_groups['+group_type+'][]" type="checkbox" value="' + group_name + '" checked><label class="collection_check_boxes">'+ group_name+'</label></span>');
      	$("#add-disease-form").addClass("hidden");
      	$("#add-disease-button").removeClass("hidden");

      } else {
      	$(this).parent().before(
      	'<div class="col-xs-6 col-sm-4 form-group"><input name="new_health_groups['+group_type+'][]" type="checkbox" value="' + group_name + '" checked><label class="checkbox-inline">'+ group_name+'</label></div>');
      }
    });

		$("#addNutritionModel, #family-page").on("click", "#new-allergy-group-button", function(e){
      e.preventDefault();
      var group_name = $(this).siblings().first().val();
      var group_type = $(this).siblings().first().data("group-type");
      $(this).parent().before(
        '<div class="col-xs-6 col-sm-4 form-group">' +
					'<input id="user_patient_group_ids_' + group_name+'" name="new_health_groups['+group_type+'][]" type="checkbox" value="' + group_name+'" checked>' +
					'<label class="checkbox-inline" for="user_patient_group_ids_' + group_name+'">'+group_name +
					'</label>' +
				'</div>');
      $(this).siblings().first().val("");
    });

	}


}    