

$(document).ready(function() {

	// override bootstrap accordion
	OverrideBootstrap.setAccordion();


	// dirty form catcher 
	FormValidation.dirty_form_catcher();
	// sign in form on pageload
	FormValidation.signInValidations();

	// ingredients_recipe form on page load
	FormValidation.unitAutofill();
	FormValidation.ingredientAutofill();
	FormValidation.displayNameAutofill();
	FormValidation.ingredientValidations();
	FormValidation.sortableIngredientList();
	
	// steps form on page load
	FormValidation.stepsValidations();

	// allergen form on page load
	FormValidation.ingredientAllergensValidations();

	// recipe categroies and health groups form set
	CategoriesPreview.setCheckBoxes();

	// qualty review allergen input form set
	FormValidation.ingredientAllergensReview();

	// Content Quota form
	FormValidation.contentQuotaValidations();

	// User sign up form
	UserSignUp.set_breadcrumbs();
	UserSignUp.appoint_self_checkbox();
	UserSignUp.nutrition_buttons();
	UserSignUp.set_intro_modal();
	UserSignUp.set_nutrition_intro_modal();
	UserSignUp.family_buttons();
	FormValidation.user_intro();
	FormValidation.nutrition_form_appt_focus();

	// Time slot calendar
	// TimeSlotCalendar.set();
	// TimeSlotCalendar.initiate_date_time_picker();
	SelectApptCalendar.set();

	// Availability Calendar
	AvailabilityCalendar.set();
	
	// user in session 
	UserSession.javascript();

	AppointmentsIndex.setButtons();

	// set up tox box size
	// actual tokbox script is at view rooms in_session 
	// TokBoxMain.responsive_screens();


	if ($("#quality-review-main-container").length >= 1){
		BasicForm.validateReview();
		BasicForm.setReviewSliders();
	} else {
		if ($(".recipe-name-autofill ").length >= 1) {
					// other elsif
			BasicForm.validate();
			BasicForm.setSliders();
		}
	};


});