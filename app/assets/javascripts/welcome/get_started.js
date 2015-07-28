

Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.getStarted = {

  init: function(){
    $("#get-started-page form").validate({
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
	      "user[phone_number]":{
	        required: true,
	        phoneUS: true
	      },
      },
      groups: {
        BirthDate: "user[date_of_birth(1i)] user[date_of_birth(2i)] user[date_of_birth(3i)]"
      },
      errorPlacement: function(error, element) {
        if (element.attr("name") == "user[date_of_birth(1i)]" || element.attr("name") == "user[date_of_birth(2i)]" || element.attr("name") == "user[date_of_birth(3i)]" ) {
          error.insertAfter("#user_date_of_birth_1i");
        } else {
          error.insertAfter(element);
        }
      },
      messages: {
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
		$("#user_phone_number").mask("1(999)999-9999");
    $("#user_zip_code").mask('99999');
  }
}
