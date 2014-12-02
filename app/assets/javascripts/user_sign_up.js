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
    $("#new-health-group-button").on("click", function(e){
      e.preventDefault();
      var group_name = $("#new-health-group-field").val();
      $(".select-allergen-box").last().after(
      "<label class='checkbox col-xs-4 select-allergen-box'><input class='check_boxes optional' name='new_health_groups[]' type='checkbox' value='"+group_name+"' checked>"+group_name+"</label>");
      $("#new-health-group-field").val("");
    })
  },
  set_intro_modal: function(){
    $("#introModal").modal("toggle");
  },
  family_buttons: function(){
    $("#family-member-list").children().first().addClass("selected-family-member");
    $(".selected-family-member a").hide();
  },
}