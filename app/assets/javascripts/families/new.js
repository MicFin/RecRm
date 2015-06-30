

var Families = {
	new: function(){
		$('input:radio').change(
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
	}
}        
// ")
// <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="1">