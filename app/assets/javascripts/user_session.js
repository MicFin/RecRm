var UserSession = {
  javascript: function(){
        //hover for feedback and help
        $('.always-hover').tooltip({trigger: 'manual'}).tooltip('show');
        $('.always-hover').on('click',function(){$(this).tooltip('destroy');});
       $(".family-button").on("click", function(e){
          e.preventDefault();
          if ($("#main-footer-list").is(":visible"))  {
            $("#main-footer-list").hide();
            $("#notes-container").hide();
            $("#family-container").removeClass("hidden");
            $("#family-container").show(800);
            $("#recipe-background").css("padding-top","2%");
            $("#nav-bottom").css("height", "210px");
          } else {
            $("#nav-bottom").css("height", "75px");
            $("#family-container").hide();
            $("#main-footer-list").show();
            $("#recipe-background").css("padding-top","5%");
          };
       });
       $(".notes-button").on("click", function(e){
          e.preventDefault();
          if ($("#main-footer-list").is(":visible"))  {
            $("#main-footer-list").hide();
            $("#notes-container").removeClass("hidden");
            $("#notes-container").show(800);
            $("#recipe-background").css("padding-top","2%");
            $("#nav-bottom").css("height", "210px");
          } else {
            $("#nav-bottom").css("height", "75px");
            $("#notes-container").hide();
            $("#main-footer-list").show();
            $("#recipe-background").css("padding-top","5%");
          };
       });
       $(".krdn-button").on("click", function(e){
          e.preventDefault();
          if ($("#main-footer-list").is(":visible"))  {
            $("#main-footer-list").hide();
            $("#notes-container").hide();
            $("#krdn-container").removeClass("hidden");
            $("#krdn-container").show(800);
            $("#recipe-background").css("padding-top","2%");
                        $("#nav-bottom").css("height", "210px");
          } else {
            $("#nav-bottom").css("height", "75px");
            $("#main-footer-list").show();
            $("#krdn-container").hide();

            $("#recipe-background").css("padding-top","5%");
          };
       });

      $("#show-chat-button").on("click", function(e){
        e.preventDefault();
        if ($("#chat-container").is(":visible") ){
          $("#chat-container").hide("slow");
          $("#phone-button-container").show("slow");
        } else {
          $("#chat-container").show("slow");
          $("#phone-container").hide("slow");
          $("#phone-button-container").hide("slow");
        };
      });
      $("#show-phone-button").on("click", function(e){
        e.preventDefault();
        if ($("#phone-container").is(":visible") ){
          $("#phone-container").hide("slow");
          $("#message-button-container").show("slow");
        } else {
          $("#message-button-container").hide("slow");
          $("#phone-container").show("slow");
        };
      });


  }
}