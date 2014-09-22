var CategoriesPreview = {
	setCheckBoxes: function(){
		$( "#nutrition-groups-form input[type=checkbox]" ).on( "click", function(){
			$("#health-groups-container .preview-info").remove();
			$("#health-groups-container").append("<div class='preview-info'></div>");
			$( "input:checked" ).parent().each(function(){
				$("#health-groups-container .preview-info").append("<div class='col-xs-3 health-group-list-item'><h4>"+$(this).text()+"</h4></div>"); 
			});
		});
		$( "#recipe-categories-form input[type=checkbox]" ).on( "click", function(){
			$("#categories-container .preview-info").remove();
			$("#categories-container").append("<div class='preview-info'></div>");
			$( "input:checked" ).parent().each(function(){
				$("#categories-container .preview-info").append("<div class='col-xs-3 health-group-list-item'><h4>"+$(this).text()+"</h4></div>"); 
			});
		});
	}
};