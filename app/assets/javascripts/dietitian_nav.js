$(document).ready(function() {

  //hover by default for feedback and help
  $('.always-hover').tooltip({trigger: 'manual'}).tooltip('show');
  // remove it when clicked
  $('.always-hover').on('click',function(){$(this).tooltip('destroy');});

  // change nav highlight based on url key word
  var pathname = window.location.pathname;
  if ((pathname.search("/recipes") >= 0) || (pathname.search("/ingredients") >= 0)) {
  	$("#kindrd-navbar li").removeClass("active");
		$("#navbar-recipes").addClass("active");
	} else if (pathname.search("/welcome") >= 0){
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
});

