
Kindrdfood = Kindrdfood || {};

Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.addFamily = {

	init: function(){

    // if appointment focus is already assigned and a checkbox is checked then
    if($('input:radio[name="appointment_focus"]:checked').length > 0){
    
      // get value of appointment focus radio buttons
      var startingClass = $('input:radio[name="appointment_focus"]:checked').val();
      
      // Unhide the selected form
      $("."+ startingClass).removeClass("hidden");

      // validate the form
      Kindrdfood.formValidations.familyMembers.validateFamilyMemberForm(startingClass);
    }



		// when user selects an appointment focus as self, a family member, or a new family member then display basic information form for that person 
		$('input:radio[name="appointment_focus"]').change(
		    function(){

          // Hide all the forms
          $("form").addClass("hidden");

          // Get the class name of the form selected
          var className = $(this).val();

          // Unhide the selected form
          $("."+className).removeClass("hidden");

          // validates form
          Kindrdfood.formValidations.familyMembers.validateFamilyMemberForm(className);
		    }
		); 

	}
}        
