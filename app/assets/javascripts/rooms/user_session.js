


Kindrdfood = Kindrdfood || {};

Kindrdfood.rooms = Kindrdfood.rooms || {};

Kindrdfood.rooms.user_session = {

	init: function(){
		// Kindrdfood.ajaxSpecific.ajaxUpdateUrl.init();
		$(".user-session-tool-video").on("click", function(e){
			e.preventDefault();
			$(".session-tools-container").addClass("hidden");
			Kindrdfood.rooms.user_session.maximizeVideo();
		})

		$(".user-session-tool-notes").on("click", function(e){
			e.preventDefault();
			$(".session-tools-container").removeClass("hidden");

			//$(".session-tools-container").html("<%= j render(:partial => '/families/list_family_members', :locals => { :family=> @family, :user => @user}) %>");
		})
	},
	minimizeVideo: function(){
			$("#layoutContainer").removeClass();
			$("#layoutContainer").addClass("col-xs-2");
	},
	maximizeVideo: function(){
			$("#layoutContainer").removeClass();
			$("#layoutContainer").addClass("col-xs-12");
	}

		
}