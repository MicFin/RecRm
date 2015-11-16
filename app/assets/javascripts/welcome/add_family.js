
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
		      	Kindrdfood.formValidations.familyMembers.validateClientForm();
          } else {
            Kindrdfood.formValidations.familyMembers.validateFamilyMemberForm(className);
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
      Kindrdfood.formValidations.familyMembers.createPregnancyLogic(className);
    }
	}
}        
