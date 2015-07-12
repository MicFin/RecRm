

var Welcome = {
	addFamily: function(){
		$('input:radio[name="appointment_focus"]').change(
		    function(){
		      if ( $(this).val() === "user-form" ) {
		      	$(".user-form").removeClass("hidden");
		      	$(".new-user-form").addClass("hidden");
		      } else {
		      	$(".new-user-form").removeClass("hidden");
		      	$(".user-form").addClass("hidden");
		      }
		    }
		); 
		$('.user-form input:radio[name="pregnancy"]').change(
		    function(){
		      if ( $(this).val() === "yes" ) {
		      	$(".user-form .due-date-container").removeClass("hidden");
		      } else {
		      	$(".user-form .due-date-container").addClass("hidden");
		      }
		    }
		); 
		$(".new-user-form select[name='user[date_of_birth(1i)]']").change(function() {
		  if ( parseInt($(this).val()) < moment().subtract(18, "years").year()){
		   	$(".new-user-form .pregnancy-container").removeClass("hidden");
		  } else { 
				$(".new-user-form .pregnancy-container").addClass("hidden");
		  }
		});
		$(".user-form select[name='user[date_of_birth(1i)]']").change(function() {
		  if ( parseInt($(this).val()) < moment().subtract(18, "years").year()){
		   	$(".user-form .pregnancy-container").removeClass("hidden");
		  } else { 
				$(".user-form .pregnancy-container").addClass("hidden");
		  }
		});

		$('.new-user-form input:radio[name="pregnancy"]').change(
		    function(){
		      if ( $(this).val() === "yes" ) {
		      	$(".new-user-form .due-date-container").removeClass("hidden");
		      } else {
		      	$(".new-user-form .due-date-container").addClass("hidden");
		      }
		    }
		);  
	},
	addNutrition: function(){
		$("#addNutritionModel").on("click", "#add-disease-button", function(e){
			$("#add-disease-form").removeClass("hidden");
			$(this).addClass("hidden");
		});
		$("#addNutritionModel").on("click", "#new-health-group-button", function(e){
      e.preventDefault();
      var group_name = $("#new-health-group-field").val();
      $("#add-disease-button").before(
      	'<span><input name="user[patient_group_ids][]" type="checkbox" value="' + group_name + '" checked><label class="collection_check_boxes">'+ group_name+'</label></span>');
      $("#new-health-group-field").val("");
      $("#add-disease-form").addClass("hidden");
      $("#add-disease-button").removeClass("hidden");
    });
		$("#addNutritionModel").on("click", "#new-allergy-group-button", function(e){
        e.preventDefault();
        var group_name = $("#add-allergy-field").val();
        $("#add-allergy-container").before(
          '<div class="col-xs-6 col-sm-4 form-group">' +
						'<input id="user_patient_group_ids_' + group_name+'" name="user[patient_group_ids][]" type="checkbox" value="' + group_name+'" checked>' +
						'<label class="checkbox-inline" for="user_patient_group_ids_' + group_name+'">'+group_name +
						'</label>' +
					'</div>');
        $("#add-allergy-field").val("");
      });

	}
}        
// ")
// <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="1">