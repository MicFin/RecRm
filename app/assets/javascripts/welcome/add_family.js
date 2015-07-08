

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
		$("#add-disease-button").on("click", function(e){
			e.preventDefault();
			$("#add-disease-form").removeClass("hidden");
			$(this).addClass("hidden");
		});
		$("#addNutritionModel").on("click", "#new-health-group-button", function(e){
	      e.preventDefault();
	      var group_name = $("#new-health-group-field").val();
	      $("#add-disease-button").before(
	      	'<span><input name="user[patient_group_ids][]" type="checkbox" value="' + group_name + '"><label class="collection_check_boxes" checked>'+ group_name+'</label></span>');
	      $("#new-health-group-field").val("");
	      $("#add-disease-form").addClass("hidden");
	      $("#add-disease-button").removeClass("hidden");
    	})

	}
}        
// ")
// <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="1">