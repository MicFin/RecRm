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
    $("#new-user-allergies-button").on("click", function(e){
      e.preventDefault();
      $('#new-user-nutrition-tabs a[href="#allergies"]').tab('show')
    });
    $("#new-user-intolerances-button").on("click", function(e){
      e.preventDefault();
      $('#new-user-nutrition-tabs a[href="#intolerances"]').tab('show')
    });
    $("#new-user-diseases-button").on("click", function(e){
      e.preventDefault();
      $('#new-user-nutrition-tabs a[href="#diseases"]').tab('show')
    });
    $("#new-user-diets-button").on("click", function(e){
      e.preventDefault();
      $('#new-user-nutrition-tabs a[href="#diets"]').tab('show')
    });
    $("#new-user-more-button").on("click", function(e){
      e.preventDefault();
      $('#new-user-nutrition-tabs a[href="#more"]').tab('show')
    });
  },
  set_intro_modal: function(){
    $("#introModal").modal("toggle");
  },
  family_buttons: function(){
    $("#family-member-list").children().first().addClass("selected-family-member");
    $(".selected-family-member a").remove();
  },
}