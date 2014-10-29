$(document).ready(function() {

  //hover by default for feedback and help
  $('.always-hover').tooltip({trigger: 'manual'}).tooltip('show');
  // remove it when clicked
  $('.always-hover').on('click',function(){$(this).tooltip('destroy');});

  // change nav highlight based on url key word
  var pathname = window.location.pathname;
  if ((pathname.search("/recipes") >= 0) || (pathname.search("/ingredients") >= 0) || (pathname.search("/recipe_steps") >= 0)) {
  	$("#kindrd-navbar li").removeClass("active");
		$("#navbar-recipes").addClass("active");
	} else if ((pathname.search("/welcome") >= 0) || (pathname.search("/") >= 0)){
		$("#kindrd-navbar li").removeClass("active");
		$("#navbar-dashboard").addClass("active");
	} else if (pathname.search("/appointments") >= 0){
		$("#kindrd-navbar li").removeClass("active");
		$("#navbar-appointments").addClass("active");
	};
	// add regex method to jquery validation // needs another home
  $.validator.addMethod(
    "regex",
    function(value, element, regexp) {
        var re = new RegExp(regexp);
        return this.optional(element) || re.test(value);
    }
  );
  // on sign in page give footer class fixed
  if ($("#sign_in_nav").length > 0){
    $("footer").addClass("fixed");
  } else {
    $("footer").removeClass("fixed");
  };

  // hide groups container for recipe steps
  $( "#group-names-container").hide();
  // show container and field or hide based onf selection
  $( "#groups-of-steps-select" ).change(function() {
    if ($( "#groups-of-steps-select" ).val() === "one"){
      $( "#recipe_step_group_name" ).attr('disabled','disabled')
      $( "#group-names-container").hide();
    } else{
      $( "#group-names-container").show();
      $( "#recipe_step_group_name" ).removeAttr('disabled')
    };
  });

  $("#accept-review-form").hide();
  $("#edit-review-form").hide();
  $("#decline-review-form").hide();
  $("#decline-review-button").on("click", function(){
    $("#accept-review-form").hide();
    $("#edit-review-form").hide();
    $("#decline-review-form").toggle(); 
    $("#first-suggestion-display").removeClass("selected-suggestion");
    $("#second-suggestion-display").removeClass("selected-suggestion");
  });
  $("#accept-review-button").on("click", function(){
    $("#edit-review-form").hide();
    $("#decline-review-form").hide();
    $("#accept-review-form").toggle();   
  });
  $("#edit-review-button").on("click", function(){
    $("#decline-review-form").hide();
    $("#accept-review-form").hide();
    $("#edit-review-form").toggle();
    $("#first-suggestion-display").removeClass("selected-suggestion");
    $("#second-suggestion-display").removeClass("selected-suggestion");
  });
  $(".accept-review-button-choice").on("click", function(){
    $("#decline-review-form").hide();
    $("#edit-review-form").hide();
    $("#accept-review-form").show();
    if ($(this).data('suggestion') == "first"){
      $("#second-suggestion-display").removeClass("selected-suggestion");
      $("#first-suggestion-display").addClass("selected-suggestion");
    } else if ($(this).data('suggestion') == "second"){
      $("#first-suggestion-display").removeClass("selected-suggestion");
      $("#second-suggestion-display").addClass("selected-suggestion");
    } else {
      $("#first-suggestion-display").removeClass("selected-suggestion");
      $("#second-suggestion-display").removeClass("selected-suggestion");
    };
    $("#hidden-suggestion-container").replaceWith("<div id='hidden-suggestion-container'><input type='hidden' name='suggestion' value='"+$(this).data('suggestion')+"'></div>");
  });
  $("#add-new-suggestion-button").on("click", function(){
    $("#decline-review-form").hide();
    $("#accept-review-form").hide();
    $("#edit-review-form").show();
    $("#first-suggestion-display").removeClass("selected-suggestion");
    $("#second-suggestion-display").removeClass("selected-suggestion");
  });
  $(".quota-data-tooltip").tooltip();

});

