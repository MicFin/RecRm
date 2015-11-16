
Kindrdfood = Kindrdfood || {};


Kindrdfood.formValidations = Kindrdfood.formValidations || {};

Kindrdfood.formValidations.familyMembers = {
 
  // Should be able to combine validateClientForm and validateFamilyMemberForm
  // Should only be very few differences between the two methods
	validateClientForm: function(){
		Kindrdfood.formValidations.familyMembers.createPregnancyLogic();
		Kindrdfood.formValidations.familyMembers.addGroupButtons();
    Kindrdfood.images.newImage.set_image_preview();
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
          required: {
            depends: function () { 
              return ($(".user-form input[name='user[height][feet]']").val() != "" );
            }
          },
          range: [0, 10],
          number: true
        },
        "user[height][inches]":{
          required: {
            depends: function () { 
              if ( ( $(".user-form input[name='user[height][inches]']").val() != "" ) || ( $(".user-form input[name='user[height][feet]']").val() == "") ) {
                return true 
              } else {
                return false
              }
            }
          },
          range: [0, 120],
          number: true
        },
        "user[weight][pounds]":{
          required: {
            depends: function () { 
              return ( $(".user-form input[name='user[weight][pounds]']").val() != "" );
            }
          },
          range: [0, 1000],
          number: true
        },
        "user[weight][ounces]":{
          required: {
            depends: function () { 
              if ( ( $(".user-form input[name='user[weight][ounces]']").val() != "" ) || ( $(".user-form input[name='user[weight][pounds]']").val() == "") ) {
                return true 
              } else {
                false
              }
            }
          },
          range: [0, 16],
          number: true
        }
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
  validateFamilyMemberForm: function(form_class_name){
  	Kindrdfood.formValidations.familyMembers.createPregnancyLogic();
  	Kindrdfood.formValidations.familyMembers.addGroupButtons();
    Kindrdfood.images.newImage.set_image_preview();
    // $("form." + form_class_name).data('validator', null);
    $("form." + form_class_name).validate({
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
          required: {
            depends: function () { 
            	if ( $("." + form_class_name + " input[name='user[height][feet]']").val() != "" ) {

            		return true;
            	} else {
            		return false;
            	}
            }
          },
          range: [0, 10],
          number: true
        },
        "user[height][inches]":{
          required: {
            depends: function () { 
              if ( ( $("." + form_class_name + " input[name='user[height][inches]']").val() != "" ) || ( $("." + form_class_name + " input[name='user[height][feet]']").val() == "") ) {
                return true 
              } else {
                return false
              }
            }
          },
          range: [0, 120],
          number: true
        },
        "user[weight][pounds]":{
          required: {
            depends: function () { 
              return ( $("." + form_class_name + " input[name='user[weight][pounds]']").val() != "" );
            }
          },
          range: [0, 1000],
          number: true
        },
        "user[weight][ounces]":{
          required: {
            depends: function () { 
              if ( ( $("." + form_class_name + " input[name='user[weight][ounces]']").val() != "" ) || ( $("." + form_class_name + " input[name='user[weight][pounds]']").val() == "") ) {
                return true 
              } else {
                false
              }
            }
          },
          range: [0, 16],
          number: true
        }
      },
      groups: {
        BirthDate: "user[date_of_birth(1i)] user[date_of_birth(2i)] user[date_of_birth(3i)]",
        Height: "user[height][feet] user[height][inches]",
        Weight: "user[weight][ounces] user[weight][pounds]"
      },
      errorPlacement: function(error, element) {

        // if the error is a birth day field then only show 1 error message below all birthday field
        if (element.attr("name") == "user[date_of_birth(1i)]" || element.attr("name") == "user[date_of_birth(2i)]" || element.attr("name") == "user[date_of_birth(3i)]" ) {
          var targetLocation = $("form." + form_class_name + " #user_date_of_birth_1i").parent();
          error.insertAfter(targetLocation);

        // if the error is the gender field then show error message below gender fields
        } else if ( element.attr("name") == "user[sex]"){
          var targetLocation = $("form."+ form_class_name + " #user_sex_male").parent().parent();
          error.insertAfter(targetLocation);

        // if the error is the height then show error message below the height
        } else if ( element.attr("name") == "user[height][feet]" || element.attr("name") == "user[height][inches]"){
          var targetLocation = $("form." + form_class_name + " #height-attributes").parent();
          error.insertAfter(targetLocation);

        // if the error is the weightr field then show error message below weight fields
        } else if ( element.attr("name") == "user[weight][pounds]" || element.attr("name") == "user[weight][ounces]"){
          var targetLocation = $("form." + form_class_name + " #weight-attributes").parent();
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
  createPregnancyLogic: function(className){
   // if user is more than 18 years old then show field for being pregnant
    $("." + className + " select[name='user[date_of_birth(1i)]']").change(function() {
      if ( parseInt($(this).val()) < moment().subtract(18, "years").year()){
        $("." + className + " .pregnancy-container").removeClass("hidden");
      } else { 
        $("." + className + " .pregnancy-container").addClass("hidden");
      }
    });

    // if user selects that they are pregnant, then show the due date field
    $("." + className + " input:radio[name='pregnancy']").change(function(){
        if ( $(this).val() === "yes" ) {
          $("." + className + " .due-date-container").removeClass("hidden");
        } else {
          $("." + className + " .due-date-container").addClass("hidden");
        }
      }
    )
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


};