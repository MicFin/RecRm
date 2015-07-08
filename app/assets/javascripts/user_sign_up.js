var UserSignUp = {
  // new user sign in form validations
  appoint_self_checkbox: function(){
    $("#appointment-self-button").on("click", function(e){
      if ($(this).is(':checked')) {
        var first_name = $("#user_first_name").val();
        var last_name = $("#user_last_name").val();
        $("#client_first_name").val(first_name).attr("disabled", true);
        $("#client_last_name").val(last_name).attr("disabled", true);
      } else {
        $("#client_first_name").val("").attr("disabled", false);
        $("#client_last_name").val("").attr("disabled", false);
      };
    })
  },
  nutrition_buttons: function(){
    // $("#new-health-group-button").on("click", function(e){
    //   e.preventDefault();
    //   var group_name = $("#new-health-group-field").val();
    //   $("#nutrition-checkboxes").append(
    //   "<label class='checkbox col-xs-4 select-allergen-box'><input class='check_boxes optional' name='new_health_groups[]' type='checkbox' value='"+group_name+"' checked>"+group_name+"</label>");
    //   $("#new-health-group-field").val("");
    // })
  },
  set_intro_modal: function(){
    $("#introModal").modal("toggle");
    // when all disclaimer boxes are checked, unhide exit disclaimer button
    $(".disclaimer-checkbox").change(function(){
      if ($('.disclaimer-checkbox:checked').length === $('.disclaimer-checkbox').length) {
        $("#exit-disclaimer-button").removeClass("hidden");
      }else{
        $("#exit-disclaimer-button").addClass("hidden");
      }
    });
    // when exit disclaimer button is clicked, check again to make sure that all disclaimers are checked or else prompt user to complete them
    $("#exit-disclaimer-button").on("click", function(e){
      if ( $('.disclaimer-checkbox:checked').length === $('.disclaimer-checkbox').length){
        return true;
      }else {
        e.preventDefault();
        alert("Please read terms of service and verify age to continue");
        return false;
      }
    });
    // when user clicks on the next disclaimer button, hide the main content and show the disclaimers content
    $("#next-disclaimer-button").on("click", function(e){
      e.preventDefault();
      $("#intro-modal-main").addClass("hidden");
      $("#intro-modal-disclaimer").removeClass("hidden");
    });
  },
  family_buttons: function(){
    $(".display-more-checkbox").on("click", function(){
      if (  ( $(this).is(":checked") ) ||  ( $(".display-more-checkbox").is(":checked") ) ) { 
        if ($(".additional-checkboxes").hasClass("hidden")) {
          $(".additional-checkboxes").hide();
          $(".additional-checkboxes").removeClass("hidden");
          $(".additional-checkboxes").slideDown("slow");
        }      
      } else {
        $(".additional-checkboxes").fadeOut("slow");
        $(".additional-checkboxes").slideUp("slow");
        $(".additional-checkboxes").hide("slow");
        $(".additional-checkboxes").addClass("hidden");
      }
    });
    $("#family-member-list").children().first().addClass("selected-family-member");
    $("#family-member-list .family-member:not(:first-child)").addClass("unselected-family-member");
    $(".selected-family-member a").hide();
    $("#user_patient_group_ids_15").on("click", function(e){
      e.preventDefault();
      $("#more-allergens-field-container").removeClass("hidden");
      $("#new-allergy-group-button").on("click", function(e){
        e.preventDefault();
        var group_name = $("#new-allergy-group-field").val();
        $("#allergies-list-container").children().children().append(
          "<label class='checkbox col-xs-4 select-allergen-box'><input class='check_boxes optional' name='new_health_groups[]' type='checkbox' value='"+group_name+"' checked>"+group_name+"</label>");
        $("#new-allergy-group-field").val("");
      });
    })
  },
  set_nutrition_intro_modal: function(){
    $("#nutritionIntroModal").modal("toggle");
  },
  set_breadcrumbs: function(){
    // change nav highlight based on url key word
    var pathname = window.location.pathname;
    var sign_up_stage = $(".bs-wizard").filter(":first").data("stage");
    if (sign_up_stage === 1) {
      $(".sign-up-step-1");
      // $(".sign-up-step-2").removeClass("disabled").addClass("complete");
      // $(".sign-up-step-3").removeClass("disabled").addClass("complete");
    } else if (sign_up_stage === 2) {
      $(".sign-up-step-1").removeClass("active").addClass("complete");
    } else if (pathname.search("/select_time") >= 0 || sign_up_stage === 3){
      $(".sign-up-step-1").removeClass("active").addClass("complete");
      $(".sign-up-step-2").removeClass("disabled").addClass("active");  
    } else if (sign_up_stage === 4){
      $(".sign-up-step-1").removeClass("active").addClass("complete");
      $(".sign-up-step-2").removeClass("disabled").addClass("complete");
      $(".sign-up-step-3").removeClass("disabled").addClass("active");
    }else{
      // do nothing
    };
  }
}