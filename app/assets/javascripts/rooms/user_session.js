


Kindrdfood = Kindrdfood || {};

Kindrdfood.rooms = Kindrdfood.rooms || {};

Kindrdfood.rooms.user_session = {

	init: function(){

		// Kindrdfood.rooms.user_session.setUpTour();
		TokBox.initialize();

		// set user video button
		$(".user-session-tool-video").on("click", function(e){
			e.preventDefault();

			// hide tool area

			$(".session-tools-container").addClass("hidden");

			// maximize video
			Kindrdfood.rooms.user_session.maximizeVideo();

			// update nav
			$("header nav li").removeClass("active");
			$(".session-nav-video").addClass("active");
		})

		// run last because currently breaks for user (not dietitian) since they dont have a countdown
		var deadline = $("#clockdiv").data("end-time");
		CountDownClock.initializeClock('clockdiv', deadline);
	},
	minimizeVideo: function(){
			$("#layoutContainer").removeClass();
			$("#layoutContainer").addClass("col-xs-2 short-video");
	},
	maximizeVideo: function(){
			$("#layoutContainer").removeClass();
			$("#layoutContainer").addClass("col-xs-12");
	},
	setUpTour: function(){

	  var tour = new Tour({
	    storage: false,
	    template: "<div class='popover tour'>" +
	      "<div class='arrow'></div>" +
	        "<h3 class='popover-title'></h3>" +
	        "<div class='popover-content'></div>" +
	        "<div class='popover-navigation'>" +
	            "<button class='btn btn-lg btn-default' data-role='prev'>« Prev</button>" +
	            "<span data-role='separator'></span>" +
	            "<button class='btn btn-lg btn-success' data-role='next'>Next »</button>" +
	            "<a class='col-xs-12' data-role='end'>End tour</button>" +
	        "</div>" +
	        "</nav>" +
	      "</div>",
	    steps: [
	      {
	        element: "#left-user-tabs",
	        title: "Your Goals are Our Mission",
	        content: "Follow this quick guide to familiarize yourself with the room before your session starts!",
	        placement: "right"
	      },
	      {
	        element: "#nav-label",
	        title: "Your Family",
	        content: "Use this menu tab to access your health information and to take notes during your appointment.",
	        placement: "right",
	        backdropPadding: {left: 10, top: 10},

	      },
	      {
	        element: "#phone-button-container",
	        title: "Having Trouble Connecting?",
	        content: "Sometimes things go wrong so we like to be prepared.  If we lose video connection, use this number to call us.",
	        placement: "left",
	        backdropPadding: {left: -50, top: 20, right: -50, bottom: -75},
	      },
	      {
	        element: "#message-button-container",
	        title: "We Text Too",
	        content: "Need to share a link or clarify something?  We can send messages but we prefer to talk 1 on 1.",
	        placement: "left",
	        backdropPadding: {left: -50, top: 20, right: -50, bottom: -75},
	      },
	      {
	        title: "Ready To Start?",
	        content: "We are excited to speak with you.  Just click End Tour to connect your video and begin your session!",
	        orphan: true
	      }
	    ],
	    backdrop: true,
	    // backdropPadding: 10,
	    onEnd: function(tour){
	      TokBox.initialize();
	    }
	  });
	  // // Initialize the tour
	  // tour.init();
	  // // Start the tour
	  // tour.start(true);
	},
	updateNavigation: function(class_to_activate){
		$("header nav li").removeClass("active");
		$("."+class_to_activate).addClass("active");

	},

	showToolPartial: function(partial){
	 $(".session-tools-container").removeClass("hidden");
   $(".session-tools-container").html(partial);
	}

		
}