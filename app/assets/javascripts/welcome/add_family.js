

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
	// formValidation: function(){
 //    $("#welcome-add-family form.user-form").validate({
 //      rules: {
	//       "user[date_of_birth(1i)]":{
	//         required: true
	//       },
	//       "user[date_of_birth(2i)]":{
	//         required: true
	//       },
	//       "user[date_of_birth(3i)]":{
	//         required: true
	//       },
	//       "user[zip_code]":{
	//         required: true,
	//         zipcodeUS: true,
	//       },
 //        "user[sex]":{
 //          required: true
 //        },
 //          "user[height][feet]":{
 //            required: function(element) {
 //              return (!$(".user-form input[name='user[height][inches]']").hasClass('valid') || $(".user-form input[name='user[height][feet]']").val() != "" || ( $(".user-form input[name='user[height][inches]']").val() === "" && $(".user-form input[name='user[height][feet]']").val() === "" ));
 //            },
 //            range: {
 //              param: [1, 10],
 //              depends: function(element) {
 //                  // if inches is not filled out then require range
 //                if (!$(".user-form input[name='user[height][inches]']").hasClass('valid')){
 //                  return true;
 //                  // else if inches is filled out and feet is not blank or 0 then require range
 //                } else if ( $(".user-form input[name='user[height][feet]']").val() != "" && $(".user-form input[name='user[height][feet]']").val() != "0" ) {
 //                  return true;
 //                  // else inches is filled out and feet is blank or 0 so do not require
 //                }  else {
 //                  return false;
 //                }
 //              }
 //            },
 //            number: true
 //          },
 //          "user[height][inches]":{
 //            required: function(element) {
 //              return (!$(".user-form input[name='user[height][feet]']").hasClass('valid') || $(".user-form input[name='user[height][inches]']").val() != "" || ( $(".user-form input[name='user[height][inches]']").val() === "" && $(".user-form input[name='user[height][feet]']").val() === "" ));
 //            },
 //            range: {
 //              param: [1, 120],
 //              depends: function(element) {
 //                  // if feet is not filled out then require range
 //                if (!$(".user-form input[name='user[height][feet]']").hasClass('valid')){
 //                  return true;
 //                  // else if feet is filled out and inches is not blank or 0 then require range
 //                } else if ( $(".user-form input[name='user[height][inches]']").val() != "" && $(".user-form input[name='user[height][inches]']").val() != "0" ) {
 //                  return true;
 //                  // else feet is filled out and inches is blank or 0 so do not require
 //                }  else {
 //                  return false;
 //                }
 //              }
 //            },
 //            number: true
 //          },
 //          "user[weight][pounds]":{
 //            required: function(element) {
 //              return (!$(".user-form input[name='user[weight][ounces]']").hasClass('valid') || $(".user-form input[name='user[weight][pounds]']").val() != ""|| ( $(".user-form input[name='user[weight][pounds]']").val() === "" && $(".user-form input[name='user[weight][inches]']").val() === "" ) );
 //            },
 //            range: {
 //              param: [1, 1000],
 //              depends: function(element) {
 //                  // if ounces is not filled out then require range
 //                if (!$(".user-form input[name='user[weight][ounces]']").hasClass('valid')){
 //                  return true;
 //                  // else if ounces is filled out and pounds is not blank or 0 then require range
 //                } else if ( $(".user-form input[name='user[weight][pounds]']").val() != "" && $(".user-form input[name='user[weight][pounds]']").val() != "0" ) {
 //                  return true;
 //                  // else ounces is filled out and pounds is blank or 0 so do not require
 //                }  else {
 //                  return false;
 //                }
 //              }
 //            },
 //            number: true
 //          },
 //          "user[weight][ounces]":{
 //            required: function(element) {
 //              return (!$(".user-form input[name='user[weight][pounds]']").hasClass('valid') || $(".user-form input[name='user[weight][ounces]']").val() != "" || ( $(".user-form input[name='user[weight][pounds]']").val() === "" && $(".user-form input[name='user[weight][ounces]']").val() === "" ));
 //            },
 //            range: {
 //              param: [1, 16],
 //              depends: function(element) {
 //                  // if pounds is not filled out then require range
 //                if (!$(".user-form input[name='user[weight][pounds]']").hasClass('valid')){
 //                  return true;
 //                  // else if pounds is filled out and ounces is not blank or 0 then require range
 //                } else if ( $(".user-form input[name='user[weight][ounces]']").val() != "" && $(".user-form input[name='user[weight][ounces]']").val() != "0" ) {
 //                  return true;
 //                  // else pounds is filled out and ounces is blank or 0 so do not require
 //                }  else {
 //                  return false;
 //                }
 //              }
 //            },
 //            number: true
 //          },
 //      },
 //      messages: {
 //        "user[date_of_birth(1i)]":{
 //          required: "Please select a valid date of birth."
 //        },
 //        "user[date_of_birth(2i)]":{
 //          required: "Please select a valid date of birth."
 //        },
 //        "user[date_of_birth(3i)]":{
 //          required: "Please select a valid date of birth."
 //        },
 //        "user[sex]":{
 //          required: "Please select a gender"
 //        },
 //        "user[height][feet]":{
 //          required: "Enter height",
 //          range: "Number between 1 and 10",
 //          number: "Number between 1 and 10"
 //        },
 //        "user[height][inches]":{
 //          required: "Enter height",
 //          range: "Number betweeen 1 and 120",
 //          number: "Number betweeen 1 and 120"
 //        },
 //        "user[weight][pounds]":{
 //          required: "Enter weight",
 //          range: "Number between 1 and 1000",
 //          number: "Number between 1 and 1000"
 //        },
 //        "user[weight][ounces]":{
 //          required: "Enter weight",
 //          range: "Number between 1 and 16",
 //          number: "Number between 1 and 16"
 //        },
 //      }
 //    });
 //    $("#welcome-add-family form.new-user-form").validate({
 //      rules: {
	//       "user[date_of_birth(1i)]":{
	//         required: true
	//       },
	//       "user[date_of_birth(2i)]":{
	//         required: true
	//       },
	//       "user[date_of_birth(3i)]":{
	//         required: true
	//       },
	//       "user[zip_code]":{
	//         required: true,
	//         zipcodeUS: true,
	//       },
 //        "user[sex]":{
 //          required: true
 //        },
	//       "user[phone_number]":{
	//         required: true,
	//         phoneUS: true
	//       },
 //      },
 //      messages: {
 //        "user[date_of_birth(1i)]":{
 //          required: "Please select a valid date of birth."
 //        },
 //        "user[date_of_birth(2i)]":{
 //          required: "Please select a valid date of birth."
 //        },
 //        "user[date_of_birth(3i)]":{
 //          required: "Please select a valid date of birth."
 //        },
	//       "user[zip_code]":{
	//         required: "Must be a valid U.S. zip code.",
	//         zipcodeUS: "Must be a valid U.S. zip code."
	//       },
 //        "user[sex]":{
 //          required: "Please select a gender"
 //        },
 //        "user[phone_number]":{
 //          required: "Must be a valid U.S. phone number.",
 //          phoneUS: "Must be a valid U.S. phone number."
 //        },
 //      }
 //    });

	// },
	addNutrition: function(){
		$("#addNutritionModel").on("click", "#add-disease-button", function(e){
			$("#add-disease-form").removeClass("hidden");
			$(this).addClass("hidden");
		});
		$("#addNutritionModel").on("click", "#new-health-group-button", function(e){
      e.preventDefault();
      var group_name = $("#new-health-group-field").val();
      $("#add-disease-button").before(
      	'<span><input name="new_health_groups[]" type="checkbox" value="' + group_name + '" checked><label class="collection_check_boxes">'+ group_name+'</label></span>');
      $("#new-health-group-field").val("");
      $("#add-disease-form").addClass("hidden");
      $("#add-disease-button").removeClass("hidden");
    });
		$("#addNutritionModel").on("click", "#new-allergy-group-button", function(e){
        e.preventDefault();
        var group_name = $("#add-allergy-field").val();
        $("#add-allergy-container").before(
          '<div class="col-xs-6 col-sm-4 form-group">' +
						'<input id="user_patient_group_ids_' + group_name+'" name="new_health_groups[]" type="checkbox" value="' + group_name+'" checked>' +
						'<label class="checkbox-inline" for="user_patient_group_ids_' + group_name+'">'+group_name +
						'</label>' +
					'</div>');
        $("#add-allergy-field").val("");
      });

	}
}        
// ")
// <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="1">