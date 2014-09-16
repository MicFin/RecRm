$(document).ready(function() {
	// add attribute to disabled breadcrumbs
	$('#recipe-breadcrumb .disabled').attr( { "data-toggle": "tooltip", "data-placement": "bottom", "title": "not yet"});
	$('#breadcrumb-basic-info a').attr({"title": "Finish recipe then edit basics"});


	// var BreadCrumb = {

	// setBreadCrumb: function(recipe_creation_stage){
	// 	if (recipe_creation_stage > 0){
	// 		$("#breadcrumb-ingredients").removeClass("disabled");
	// 		$("#breadcrumb-ingredients").tooltip("disable");
	// 	};
	// };
	var recipe_creation_stage = $("#recipe-breadcrumb").data("stage");
	if (recipe_creation_stage >= 1){
		$("#breadcrumb-ingredients").removeClass("disabled");
		$("#breadcrumb-ingredients").tooltip("disable");

	};
	if (recipe_creation_stage >= 2){
		// update breadcrumb steps now enabled
		$("#breadcrumb-steps").removeClass("disabled");
		$("#breadcrumb-steps").tooltip("disable");
	};

	if (recipe_creation_stage >= 3){
		$("#breadcrumb-allergy-information").removeClass("disabled");
		$("#breadcrumb-allergy-information").tooltip("disable");
	};

	if (recipe_creation_stage >= 4){
		$("#breadcrumb-category-drop-down").removeClass("disabled");
		$("#breadcrumb-category-drop-down").tooltip("disable");
		$("#breadcrumb-health-groups").removeClass("disabled");
		$("#breadcrumb-health-groups").tooltip("disable");
	};

	if (recipe_creation_stage >= 5){
		$("#breadcrumb-categories").removeClass("disabled");
		$("#breadcrumb-categories").tooltip("disable");
	};

	if (recipe_creation_stage >= 6){
		$("#breadcrumb-personalize-group").removeClass("disabled");
		$("#breadcrumb-personalize-group").tooltip("disable");
	};

	if (recipe_creation_stage >= 7){
		$("#breadcrumb-review").removeClass("disabled");
		$("#breadcrumb-review").tooltip("disable");
	};

		// enable tooltip for disabled breadcrumbs
	$('#recipe-breadcrumb .disabled').tooltip();
	$('#recipe-breadcrumb .disabled').on("click", function(e){
		e.preventDefault();
	});
});