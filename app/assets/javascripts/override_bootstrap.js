var OverrideBootstrap = {
  // override bootstrap accordion to work with non standard set up
  setAccordion: function(){
    $('#quality-review-main-container .panel-title > a').on("click", function(e){
      e.preventDefault();
      var target_id = $(this).attr('href');
      if ($("#accordion .in").length > 0) {
        if ($(target_id).hasClass("in")){
          $(target_id).collapse("hide");
        } else {
          $("#accordion .in").collapse("hide");
          $(target_id).collapse('show');
        };
      } else {
        $(target_id).collapse('show');
      };
      return false;
    });
  }
};