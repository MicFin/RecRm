$(document).ready(function() {

	$("#main-article-form-container").hide();
	$("#start-writing-button").click(function(){
		$("#not-main-article-form-container").hide();
		$("#main-article-form-container").show("slow");		
	})

	$("#new-tweet-content").hide();
	$("#new-introduction-content").hide();
	$("#new-headline-content").hide();

});