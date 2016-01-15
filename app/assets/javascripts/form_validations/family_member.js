
Kindrdfood = Kindrdfood || {};


Kindrdfood.formValidations = Kindrdfood.formValidations || {};

Kindrdfood.formValidations.familyMembers = {
  validationMessages: {
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
  },
  validationGroups: {
    BirthDate: "user[date_of_birth(1i)] user[date_of_birth(2i)] user[date_of_birth(3i)]",
    Height: "user[height][feet] user[height][inches]",
    Weight: "user[weight][ounces] user[weight][pounds]"
  },
  validationRules: function(form_class_name){
    return {
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
      // For height, feet must be validated if it is entered. Feet range is numbers only, 0 to 10 
      "user[height][feet]":{
        required: {
          depends: function () { 
            return ( $("." + form_class_name + " input[name='user[height][feet]']").val() != "" );
          }
        },
        range: [0, 10],
        number: true
      },
      // For height, inches must be validated if it is entered or if no feet are entered.  Inches range is numbers only 0 to 120.
      "user[height][inches]":{
        required: {
          depends: function () { 
            return ( ( $("." + form_class_name + " input[name='user[height][inches]']").val() != "" ) || ( $("." + form_class_name + " input[name='user[height][feet]']").val() == "") )
          }
        },
        range: [0, 120],
        number: true
      },
        // For weight, pounds must be validated if it is entered.  Pounds range is numbers, 0 to 1000
        "user[weight][pounds]":{
          required: {
            depends: function () { 
              return ( $("." + form_class_name + " input[name='user[weight][pounds]']").val() != "" );
            }
          },
          range: [0, 1000],
          number: true
        },

        // For weight, ounces must be validated if it is entered or if no pounds are entered.  Ounces range is numbers only 0 to 16.
        "user[weight][ounces]":{
          required: {
            depends: function () { 
              return ( ( $("." + form_class_name + " input[name='user[weight][ounces]']").val() != "" ) || ( $("." + form_class_name + " input[name='user[weight][pounds]']").val() == "") );
            
            }
          },
          range: [0, 500],
          number: true
        }
    }
  },
  validationErrorPlacement: function(form_class_name, error, element){
    if (form_class_name === "user-form"){
       // if the error is a birth day field then only show 1 error message below all birthday field
        if (element.attr("name") == "user[date_of_birth(1i)]" || element.attr("name") == "user[date_of_birth(2i)]" || element.attr("name") == "user[date_of_birth(3i)]" ) {
          var targetLocation = $("form.user-form #user_date_of_birth_1i").parent().parent();
          error.insertAfter(targetLocation);
        // if the error is the gender field then show error message below gender fields
        } else if ( element.attr("name") == "user[sex]"){
          var targetLocation = $("form.user-form #user_sex_male").parent().parent();
          error.insertAfter(targetLocation);

        // if the error is the height then show error message below the height
        } else if ( element.attr("name") == "user[height][feet]" || element.attr("name") == "user[height][inches]"){
          var targetLocation = $("form.user-form #height-attributes").parent();
          error.insertAfter(targetLocation);

        // if the error is the weightr field then show error message below weight fields
        } else if ( element.attr("name") == "user[weight][pounds]" || element.attr("name") == "user[weight][ounces]"){
          var targetLocation = $("form.user-form #weight-attributes").parent();
          error.insertAfter(targetLocation);


        // all other errors go after the relevant field
        } else {
          error.insertAfter(element);
        }
    } else {

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
    }
  },
  createPregnancyLogic: function(className){

   // on birth date change 
    $("." + className + " select[name='user[date_of_birth(1i)]']").change(function() {
      // if person is over 16 and female then show pregnancy option, if not then hide
      if ( parseInt($(this).val()) < moment().subtract(16, "years").year() && $("." + className + " input[name='user[sex]']:checked").val() === "female" ) {
        $("." + className + " .pregnancy-container").removeClass("hidden");
      } else { 
        $("." + className + " .pregnancy-container").addClass("hidden");
      }
    });

   // on gender change 
    $("." + className + " input[name='user[sex]']").change(function() {
      // if person is over 16 and female then show pregnancy option, if not then hide
      if ( parseInt($("." + className +" select[name='user[date_of_birth(1i)]").val()) < moment().subtract(16, "years").year() && $("." + className + " input[name='user[sex]']:checked").val() === "female" ) {
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
	},
  validateFamilyMemberForm: function(form_class_name){
    Kindrdfood.formValidations.familyMembers.createPregnancyLogic(form_class_name);
    Kindrdfood.formValidations.familyMembers.addGroupButtons();
    Kindrdfood.images.newImage.set_image_preview();

    $("form." + form_class_name).validate({
      rules: Kindrdfood.formValidations.familyMembers.validationRules(form_class_name),
      groups: Kindrdfood.formValidations.familyMembers.validationGroups,
      errorPlacement: function(error, element) {
        Kindrdfood.formValidations.familyMembers.validationErrorPlacement(form_class_name, error, element);
      },
      messages: Kindrdfood.formValidations.familyMembers.validationMessages,
    });
  }
};