


Kindrdfood = Kindrdfood || {};

Kindrdfood.rooms = Kindrdfood.rooms || {};

Kindrdfood.rooms.user_session = {

	init: function(){

	},
	minimizeVideo: function(){
			$("#layoutContainer").removeClass();
			$("#layoutContainer").addClass("col-xs-2");
	},
	maximizeVideo: function(){
			$("#layoutContainer").removeClass();
			$("#layoutContainer").addClass("col-xs-offset-2 col-xs-8");
	}

		
}