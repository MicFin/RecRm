

$(document).ready(function() {
	var pathname = window.location.pathname;
	// override bootstrap accordion
	OverrideBootstrap.setAccordion();


	// dirty form catcher 
	if ((pathname.search("/provider3126") >= 0) || (pathname.search("/provider9172") >= 0) ){

	} else {
		FormValidation.dirty_form_catcher();
	};
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

	// Set half and one hour calendars
	TimeSlotsDetailedCalenders.set_half_and_one_hour_calendars();
	// Select Appointmet Calendar
	SelectApptCalendar.set();

	// Availability Calendar
	AvailabilityCalendar.set();
	
	// user in session 
	UserSession.javascript();

	AppointmentsIndex.setButtons();

	// set up tox box size
	// actual tokbox script is at view rooms in_session 
	// TokBoxMain.responsive_screens();

	DietitianEditProfile.set_button();
	DietitianEditProfile.set_image_preview();
	// set cropping of images 
	Images.set_crop();

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


	// if url is landing page url or is home page with the full page ID 
	// can probably just change to if #fullpage for both use cases
  if ( (pathname.search("/Ta10lI8839dAmi") >= 0) || ( (pathname.search("/") >= 0) && ($("#fullpage").length > 0) ) ) {
  	// 	if ($(window).width() < 960) {
   // 			alert('Less than 960');
			// } else {
				// landing page one page slide
				JqueryFullpage.adjustBody();
				JqueryFullpage.run();

				if ( $("#fullpage.provider-landing-page").length > 0) {
					$("#fullpage.provider-landing-page button").on("click", function(e){
						e.preventDefault();
						$(".hidden").removeClass("hidden");
						setTimeout(function(){
							$('#fullpage').fullpage({navigation: true, responsive: 768});
							setTimeout(function(){
								$("#fullpage").fullpage.moveTo(2);
							}, 1000);
						}, 1000);
					});
						
				} else {
					JqueryFullpage.prepareMainPage();
				}

				HomePage.setLinks();
			// };
			// $(window).resize(function() {
			// 	if ($(window).width() < 960) {
   // 				alert('Less than 960');
			// 	} else {
			// 		// landing page one page slide
			// 		JqueryFullpage.adjustBody();
			// 		JqueryFullpage.run();
			// 		HomePage.setLinks();
			// 	}
			// });
	}

});