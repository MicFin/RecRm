
Kindrdfood = Kindrdfood || {};

Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.getStarted = {

  init: function(){

    // set form validation
    $("#get-started-page form").validate({
      rules: {
        "user[first_name]":{
          required: true,
          minlength: 2
        },
        "user[last_name]":{
          required: true,
          minlength: 2
        },
	      "user[date_of_birth(1i)]":{
	        required: true,
          check_date_of_birth: true
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
	      "user[phone_number]":{
	        required: true,
	        phoneUS: true
	      },
      },
      groups: {
        BirthDate: "user[date_of_birth(1i)] user[date_of_birth(2i)] user[date_of_birth(3i)]"
      },
      errorPlacement: function(error, element) {

        // if the error is a birth day field then only show 1 error message below all birthday field
        if (element.attr("name") == "user[date_of_birth(1i)]" || element.attr("name") == "user[date_of_birth(2i)]" || element.attr("name") == "user[date_of_birth(3i)]" ) {
          error.insertAfter("#user_date_of_birth_1i");

        // if the error is the gender field then show error message below gender fields
        } else if ( element.attr("name") == "user[sex]"){
          var targetLocation = $("#user_sex_male").parent().parent();
          error.insertAfter(targetLocation);

        // all other errors go after the relevant field
        } else {
          error.insertAfter(element);
        }
      },
      messages: {
        "user[first_name]":{
          required: "Enter first name",
          minlength: "Must be at least 2 letter"
        },
        "user[last_name]":{
          required: "Enter last name",
          minlength: "Must be at least 2 letter"
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

	      "user[zip_code]":{
	        required: "Must be a valid U.S. zip code.",
	        zipcodeUS: "Must be a valid U.S. zip code."
	      },
        "user[sex]":{
          required: "Please select a gender"
        },
        "user[phone_number]":{
          required: "Must be a valid U.S. phone number.",
          phoneUS: "Must be a valid U.S. phone number."
        },
      }
    });

    // set masking rules for phone number and zip code
		$("#user_phone_number").mask("1(999)999-9999");
    $("#user_zip_code").mask('99999');

    // default timezone to browser timezone
    var timezone = jstz.determine();
    var rails_timezone = window.RailsTimeZone.to(timezone.name());
    $("#get-started-page form #user_time_zone").val(rails_timezone);


    // set popovers    
    Kindrdfood.bootstrapOverrides.popOver.init();

    // set privacy modal link in popup
    $("body").on("click", ".privacy-modal-link", function(e){
      e.preventDefault();
      $("#privacy-modal").modal();
    });
  }
}
