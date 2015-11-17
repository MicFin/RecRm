
Kindrdfood = Kindrdfood || {};


Kindrdfood.formValidations = Kindrdfood.formValidations || {};

Kindrdfood.formValidations.surveys = {
  openResponse: function(){
  	var name, rules = {}, messages = {};
		$.each( $("textarea"), function( i, input ){
			name = $(input).attr("name"); 
  		rules[name] = {required: true};
  		messages[name]= {required: "Mandatory fields."}
  	});

		$(".edit_survey, .new_survey").validate({
    	rules: rules,
      messages: messages
    })  		
  }
}