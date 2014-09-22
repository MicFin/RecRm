$(document).ready(function() {

	// ingredients_recipe form on page load
	FormValidation.unitAutofill();
	FormValidation.ingredientAutofill();
	FormValidation.displayNameAutofill();
	FormValidation.ingredientValidations();

	// steps form on page load
	FormValidation.stepsValidations();

	// allergen form on page load
	FormValidation.ingredientAllergensValidations();

	// recipe categroies and health groups form set
	CategoriesPreview.setCheckBoxes();
});