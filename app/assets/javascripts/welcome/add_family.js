
Kindrdfood = Kindrdfood || {};

Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.addFamily = {

	init: function(){

		// user selects self, a family member, or a new family member to display basic information form 
		$('input:radio[name="appointment_focus"]').change(
		    function(){

          // Hide all the forms
          $("form").addClass("hidden");

          // Get the class name of the form selected
          var className = $(this).val();

          // Unhide the selected form
          $("."+className).removeClass("hidden");

          // Validate form
		      if ( className === "user-form" ) {
		      	Kindrdfood.welcome.addFamily.validateClientForm();
          } else {
            Kindrdfood.welcome.addFamily.validateFamilyMemberForm(className);
		      }
		    }
		); 

    // Get the number of forms
    var numForms = $("form").count; 

    // Create an array of user form and new user form 
    var formClasses = ["new-user-form", "user-form"];

    // If there are more than the 2 forms then add them to the array
    // Their class names are created using an index starting at 1
    if (numForms > 2) {
      for(var i = 1; i < numForms - 1; i++){
          formClasses.push("family-member-form-"+i);
      }
      
    }
    
    // get total number of form classes 
    var numFormClasses = formClasses.length;

    // Loop through all the formClasses
    for (var i = 0; i < numFormClasses; i++) {

      // Get form class name
      var className = formClasses[i];

      // Add pregenancy logic to each form
      Kindrdfood.welcome.addFamily.createPregnancyLogic(className);
    }
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
    ); 
  },
  // Should be able to combine validateClientForm and validateFamilyMemberForm
  // Should only be very few differences between the two methods
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
  validateFamilyMemberForm: function(form_class_name){
    $("#welcome-add-family form." + form_class_name).validate({
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
          var targetLocation = $("#welcome-add-family form." + form_class_name + " #user_date_of_birth_1i").parent();
          error.insertAfter(targetLocation);

        // if the error is the gender field then show error message below gender fields
        } else if ( element.attr("name") == "user[sex]"){
          var targetLocation = $("#welcome-add-family form."+ form_class_name + " #user_sex_male").parent().parent();
          error.insertAfter(targetLocation);

        // if the error is the height then show error message below the height
        } else if ( element.attr("name") == "user[height][feet]" || element.attr("name") == "user[height][inches]"){
          var targetLocation = $("#welcome-add-family form." + form_class_name + " #height-attributes").parent();
          error.insertAfter(targetLocation);

        // if the error is the weightr field then show error message below weight fields
        } else if ( element.attr("name") == "user[weight][pounds]" || element.attr("name") == "user[weight][ounces]"){
          var targetLocation = $("#welcome-add-family form." + form_class_name + " #weight-attributes").parent();
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

  }
}        
