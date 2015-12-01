

$(document).ready(function() {


	// dirty form catcher 
	DirtyFormCatcher..start();

	// Set half and one hour calendars
	TimeSlotsDetailedCalenders.set_half_and_one_hour_calendars();

	// Select Appointmet Calendar
	SelectApptCalendar.set();

	// Availability Calendar
	AvailabilityCalendar.set();
	

	AppointmentsIndex.setButtons();


	DietitianEditProfile.set_button();
	DietitianEditProfile.set_image_preview();



});