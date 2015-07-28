
Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.addFamily = {

	init: function(){

		// user selects self or family member to display basic information form for either
		$('input:radio[name="appointment_focus"]').change(
		    function(){
		      if ( $(this).val() === "user-form" ) {
		      	$(".user-form").removeClass("hidden");
		      	$(".new-user-form").addClass("hidden");
		      	Kindrdfood.welcome.addFamily.validateClientForm();
		      } else {
		      	$(".new-user-form").removeClass("hidden");
		      	$(".user-form").addClass("hidden");
		      	Kindrdfood.welcome.addFamily.validateNewUserForm();
		      }
		    }
		); 

		// if user selects that they are pregnant, then show the due date field
		$('.user-form input:radio[name="pregnancy"]').change(
		    function(){
		      if ( $(this).val() === "yes" ) {
		      	$(".user-form .due-date-container").removeClass("hidden");
		      } else {
		      	$(".user-form .due-date-container").addClass("hidden");
		      }
		    }
		); 

		// if new user is more than 18 years old then show field for being pregnant
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
	validateClientForm: function(){
    $("#welcome-add-family form.user-form").validate({
      rules: {
	      "user[date_of_birth(1i)]":{
	        required: true
	      },
	      "user[date_of_birth(2i)]":{
	        required: true
	      },
	      "user[date_of_birth(3i)]":{
	        required: true
	      },
	      "user[zip_code]":{
	        required: true,
	        zipcodeUS: true,
	      },
        "user[sex]":{
          required: true
        },
          "user[height][feet]":{
            required: function(element) {
              return (!$(".user-form input[name='user[height][inches]']").hasClass('valid') || $(".user-form input[name='user[height][feet]']").val() != "" || ( $(".user-form input[name='user[height][inches]']").val() === "" && $(".user-form input[name='user[height][feet]']").val() === "" ));
            },
            range: {
              param: [1, 10],
              depends: function(element) {
                  // if inches is not filled out then require range
                if (!$(".user-form input[name='user[height][inches]']").hasClass('valid')){
                  return true;
                  // else if inches is filled out and feet is not blank or 0 then require range
                } else if ( $(".user-form input[name='user[height][feet]']").val() != "" && $(".user-form input[name='user[height][feet]']").val() != "0" ) {
                  return true;
                  // else inches is filled out and feet is blank or 0 so do not require
                }  else {
                  return false;
                }
              }
            },
            number: true
          },
          "user[height][inches]":{
            required: function(element) {
              return (!$(".user-form input[name='user[height][feet]']").hasClass('valid') || $(".user-form input[name='user[height][inches]']").val() != "" || ( $(".user-form input[name='user[height][inches]']").val() === "" && $(".user-form input[name='user[height][feet]']").val() === "" ));
            },
            range: {
              param: [1, 120],
              depends: function(element) {
                  // if feet is not filled out then require range
                if (!$(".user-form input[name='user[height][feet]']").hasClass('valid')){
                  return true;
                  // else if feet is filled out and inches is not blank or 0 then require range
                } else if ( $(".user-form input[name='user[height][inches]']").val() != "" && $(".user-form input[name='user[height][inches]']").val() != "0" ) {
                  return true;
                  // else feet is filled out and inches is blank or 0 so do not require
                }  else {
                  return false;
                }
              }
            },
            number: true
          },
          "user[weight][pounds]":{
            required: function(element) {
              return (!$(".user-form input[name='user[weight][ounces]']").hasClass('valid') || $(".user-form input[name='user[weight][pounds]']").val() != ""|| ( $(".user-form input[name='user[weight][pounds]']").val() === "" && $(".user-form input[name='user[weight][inches]']").val() === "" ) );
            },
            range: {
              param: [1, 1000],
              depends: function(element) {
                  // if ounces is not filled out then require range
                if (!$(".user-form input[name='user[weight][ounces]']").hasClass('valid')){
                  return true;
                  // else if ounces is filled out and pounds is not blank or 0 then require range
                } else if ( $(".user-form input[name='user[weight][pounds]']").val() != "" && $(".user-form input[name='user[weight][pounds]']").val() != "0" ) {
                  return true;
                  // else ounces is filled out and pounds is blank or 0 so do not require
                }  else {
                  return false;
                }
              }
            },
            number: true
          },
          "user[weight][ounces]":{
            required: function(element) {
              return (!$(".user-form input[name='user[weight][pounds]']").hasClass('valid') || $(".user-form input[name='user[weight][ounces]']").val() != "" || ( $(".user-form input[name='user[weight][pounds]']").val() === "" && $(".user-form input[name='user[weight][ounces]']").val() === "" ));
            },
            range: {
              param: [1, 16],
              depends: function(element) {
                  // if pounds is not filled out then require range
                if (!$(".user-form input[name='user[weight][pounds]']").hasClass('valid')){
                  return true;
                  // else if pounds is filled out and ounces is not blank or 0 then require range
                } else if ( $(".user-form input[name='user[weight][ounces]']").val() != "" && $(".user-form input[name='user[weight][ounces]']").val() != "0" ) {
                  return true;
                  // else pounds is filled out and ounces is blank or 0 so do not require
                }  else {
                  return false;
                }
              }
            },
            number: true
          },
      },
      groups: {
        BirthDate: "user[date_of_birth(1i)] user[date_of_birth(2i)] user[date_of_birth(3i)]",
        Height: "user[height][feet] user[height][inches]",
        Weight: "user[weight][ounces] user[weight][pounds]"
      },
      errorPlacement: function(error, element) {

        // if the error is a birth day field then only show 1 error message below all birthday field
        if (element.attr("name") == "user[date_of_birth(1i)]" || element.attr("name") == "user[date_of_birth(2i)]" || element.attr("name") == "user[date_of_birth(3i)]" ) {
					var targetLocation = $("#welcome-add-family form.user-form #user_date_of_birth_1i").parent().parent();
          error.insertAfter(targetLocation);
        // if the error is the gender field then show error message below gender fields
        } else if ( element.attr("name") == "user[sex]"){
          var targetLocation = $("#welcome-add-family form.user-form #user_sex_male").parent().parent();
          error.insertAfter(targetLocation);

        // if the error is the height then show error message below the height
        } else if ( element.attr("name") == "user[height][feet]" || element.attr("name") == "user[height][inches]"){
          var targetLocation = $("#welcome-add-family form.user-form #height-attributes").parent();
          error.insertAfter(targetLocation);

        // if the error is the weightr field then show error message below weight fields
        } else if ( element.attr("name") == "user[weight][pounds]" || element.attr("name") == "user[weight][ounces]"){
          var targetLocation = $("#welcome-add-family form.user-form #weight-attributes").parent();
          error.insertAfter(targetLocation);


        // all other errors go after the relevant field
        } else {
          error.insertAfter(element);
        }
      },
      messages: {
        "user[first_name]":{
          required: "Please enter a first name.",
          minlength: "Must be more than 2 letters."
        },
        "user[last_name]":{
          required: "Please enter a last name.",
          minlength: "Must be more than 2 letters."
        },
        "user[date_of_birth(1i)]":{
          required: "Please select a valid date of birth."
        },
        "user[date_of_birth(2i)]":{
          required: "Please select a valid date of birth."
        },
        "user[date_of_birth(3i)]":{
          required: "Please select a valid date of birth."
        },
        "user[sex]":{
          required: "Please select a gender"
        },
        "user[height][feet]":{
          required: "Enter height like 4 feet 3 inches",
          range: "Enter height like 4 feet 3 inches",
          number: "Enter height like 4 feet 3 inches"
        },
        "user[height][inches]":{
          required: "Enter height like 4 feet 3 inches",
          range: "Enter height like 4 feet 3 inches",
          number: "Enter height like 4 feet 3 inches"
        },
        "user[weight][pounds]":{
          required: "Enter weight like 10 pounds 6 ounces",
          range: "Enter weight like 10 pounds 6 ounces",
          number: "Enter weight like 10 pounds 6 ounces"
        },
        "user[weight][ounces]":{
          required: "Enter weight like 10 pounds 6 ounces",
          range: "Enter weight like 10 pounds 6 ounces",
          number: "Enter weight like 10 pounds 6 ounces"
        },
      }
    });
	},
	validateNewUserForm: function(){
    $("#welcome-add-family form.new-user-form").validate({
      rules: {
        "user[first_name]":{
          required: true,
          minlength: 2
        },
        "user[last_name]":{
          required: true,
          minlength: 2
        },
        "user[family_role]":{
          required: true,
          minlength: 2
        },
	      "user[date_of_birth(1i)]":{
	        required: true
	      },
	      "user[date_of_birth(2i)]":{
	        required: true
	      },
	      "user[date_of_birth(3i)]":{
	        required: true
	      },
	      "user[zip_code]":{
	        required: true,
	        zipcodeUS: true,
	      },
        "user[sex]":{
          required: true
        },
          "user[height][feet]":{
            required: function(element) {
              return (!$(".user-form input[name='user[height][inches]']").hasClass('valid') || $(".user-form input[name='user[height][feet]']").val() != "" || ( $(".user-form input[name='user[height][inches]']").val() === "" && $(".user-form input[name='user[height][feet]']").val() === "" ));
            },
            range: {
              param: [1, 10],
              depends: function(element) {
                  // if inches is not filled out then require range
                if (!$(".user-form input[name='user[height][inches]']").hasClass('valid')){
                  return true;
                  // else if inches is filled out and feet is not blank or 0 then require range
                } else if ( $(".user-form input[name='user[height][feet]']").val() != "" && $(".user-form input[name='user[height][feet]']").val() != "0" ) {
                  return true;
                  // else inches is filled out and feet is blank or 0 so do not require
                }  else {
                  return false;
                }
              }
            },
            number: true
          },
          "user[height][inches]":{
            required: function(element) {
              return (!$(".user-form input[name='user[height][feet]']").hasClass('valid') || $(".user-form input[name='user[height][inches]']").val() != "" || ( $(".user-form input[name='user[height][inches]']").val() === "" && $(".user-form input[name='user[height][feet]']").val() === "" ));
            },
            range: {
              param: [1, 120],
              depends: function(element) {
                  // if feet is not filled out then require range
                if (!$(".user-form input[name='user[height][feet]']").hasClass('valid')){
                  return true;
                  // else if feet is filled out and inches is not blank or 0 then require range
                } else if ( $(".user-form input[name='user[height][inches]']").val() != "" && $(".user-form input[name='user[height][inches]']").val() != "0" ) {
                  return true;
                  // else feet is filled out and inches is blank or 0 so do not require
                }  else {
                  return false;
                }
              }
            },
            number: true
          },
          "user[weight][pounds]":{
            required: function(element) {
              return (!$(".user-form input[name='user[weight][ounces]']").hasClass('valid') || $(".user-form input[name='user[weight][pounds]']").val() != ""|| ( $(".user-form input[name='user[weight][pounds]']").val() === "" && $(".user-form input[name='user[weight][inches]']").val() === "" ) );
            },
            range: {
              param: [1, 1000],
              depends: function(element) {
                  // if ounces is not filled out then require range
                if (!$(".user-form input[name='user[weight][ounces]']").hasClass('valid')){
                  return true;
                  // else if ounces is filled out and pounds is not blank or 0 then require range
                } else if ( $(".user-form input[name='user[weight][pounds]']").val() != "" && $(".user-form input[name='user[weight][pounds]']").val() != "0" ) {
                  return true;
                  // else ounces is filled out and pounds is blank or 0 so do not require
                }  else {
                  return false;
                }
              }
            },
            number: true
          },
          "user[weight][ounces]":{
            required: function(element) {
              return (!$(".user-form input[name='user[weight][pounds]']").hasClass('valid') || $(".user-form input[name='user[weight][ounces]']").val() != "" || ( $(".user-form input[name='user[weight][pounds]']").val() === "" && $(".user-form input[name='user[weight][ounces]']").val() === "" ));
            },
            range: {
              param: [1, 16],
              depends: function(element) {
                  // if pounds is not filled out then require range
                if (!$(".user-form input[name='user[weight][pounds]']").hasClass('valid')){
                  return true;
                  // else if pounds is filled out and ounces is not blank or 0 then require range
                } else if ( $(".user-form input[name='user[weight][ounces]']").val() != "" && $(".user-form input[name='user[weight][ounces]']").val() != "0" ) {
                  return true;
                  // else pounds is filled out and ounces is blank or 0 so do not require
                }  else {
                  return false;
                }
              }
            },
            number: true
          },
      },
      groups: {
        BirthDate: "user[date_of_birth(1i)] user[date_of_birth(2i)] user[date_of_birth(3i)]",
        Height: "user[height][feet] user[height][inches]",
        Weight: "user[weight][ounces] user[weight][pounds]"
      },
      errorPlacement: function(error, element) {

        // if the error is a birth day field then only show 1 error message below all birthday field
        if (element.attr("name") == "user[date_of_birth(1i)]" || element.attr("name") == "user[date_of_birth(2i)]" || element.attr("name") == "user[date_of_birth(3i)]" ) {
        	var targetLocation = $("#welcome-add-family form.new-user-form #user_date_of_birth_1i").parent();
          error.insertAfter(targetLocation);

        // if the error is the gender field then show error message below gender fields
        } else if ( element.attr("name") == "user[sex]"){
          var targetLocation = $("#welcome-add-family form.new-user-form #user_sex_male").parent().parent();
          error.insertAfter(targetLocation);

        // if the error is the height then show error message below the height
        } else if ( element.attr("name") == "user[height][feet]" || element.attr("name") == "user[height][inches]"){
          var targetLocation = $("#welcome-add-family form.new-user-form #height-attributes").parent();
          error.insertAfter(targetLocation);

        // if the error is the weightr field then show error message below weight fields
        } else if ( element.attr("name") == "user[weight][pounds]" || element.attr("name") == "user[weight][ounces]"){
          var targetLocation = $("#welcome-add-family form.new-user-form #weight-attributes").parent();
          error.insertAfter(targetLocation);


        // all other errors go after the relevant field
        } else {
          error.insertAfter(element);
        }
      },
      messages: {
        "user[first_name]":{
          required: "Please enter a first name.",
          minlength: "Must be more than 2 letters."
        },
        "user[last_name]":{
          required: "Please enter a last name.",
          minlength: "Must be more than 2 letters."
        },
        "user[family_role]":{
          required: "How are they related to you?",
          minlength: "Must be more than 2 letters."
        },
        "user[date_of_birth(1i)]":{
          required: "Please select a valid date of birth."
        },
        "user[date_of_birth(2i)]":{
          required: "Please select a valid date of birth."
        },
        "user[date_of_birth(3i)]":{
          required: "Please select a valid date of birth."
        },
        "user[sex]":{
          required: "Please select a gender"
        },
        "user[height][feet]":{
          required: "Enter height like 4 feet 3 inches",
          range: "Enter height like 4 feet 3 inches",
          number: "Enter height like 4 feet 3 inches"
        },
        "user[height][inches]":{
          required: "Enter height like 4 feet 3 inches",
          range: "Enter height like 4 feet 3 inches",
          number: "Enter height like 4 feet 3 inches"
        },
        "user[weight][pounds]":{
          required: "Enter weight like 10 pounds 6 ounces",
          range: "Enter weight like 10 pounds 6 ounces",
          number: "Enter weight like 10 pounds 6 ounces"
        },
        "user[weight][ounces]":{
          required: "Enter weight like 10 pounds 6 ounces",
          range: "Enter weight like 10 pounds 6 ounces",
          number: "Enter weight like 10 pounds 6 ounces"
        },
      }
    });

	},
	addNutrition: function(){
	
		// input for patient groups and has a data-trigger of true
		$("input[name='user[patient_group_ids][]'][data-triggers='true']").on("click", function(e){
		
	    if ( $("input[name='user[patient_group_ids][]'][data-triggers='true']").is(":checked") ) {
	        $('.triggers-container').removeClass("hidden");
	    } 
	    else {
	        $('.triggers-container ').addClass("hidden");
	    }
		});


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