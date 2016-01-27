
Kindrdfood = Kindrdfood || {};

Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.setAppointment = {
  startDate: function(){
    // start date is set to today
    var start_date = new Date(); 
    start_date.setDate( start_date.getDate() + 0 );
    return start_date;
  },
  unavailableTimeSlots: [],
  availableTimeSlots: [],
	init: function(){
    this.setRequestTimeButton();
    this.setChangeTimeZone();
    this.setAppointmentDietitian();
    // inititate fullcalendar
    $('#select-appt-cal').fullCalendar({

      // full calendar heading
      header: {
            left:   'prev',
            center: '',
            right:  'next'
      },

      // full calendar view settings
      views: {
        agendaThreeDay: {
            type: 'basic',
            duration: { days: 3 },
            buttonText: '3 day'
        }
      },

      // full calendar events from url
      events: {
        url: '/time_slots.json',
        type: 'GET',
        data: {
        },
        error: function() {
          alert('There was an error while fetching times.');
        },
      },

      // full calendar display event end settings
      displayEventEnd: {
        month: false,
        agendaWeek: false,
        'default': false,
        agendaThreeDay: false
      },

       // other full calendar settings
      defaultView: 'agendaThreeDay',
      timezone: "local",
      allDaySlot: false,
      allDayText: false,
      slotDuration: '00:30:00',
      minTime: "08:00:00",
      maxTime: "24:00:00",
      columnFormat: 'ddd M/DD/YY',
      height: 500,
      eventBackgroundColor: "#399E48",
      eventBorderColor: "#11753B",
      slotEventOverlap: false,

      // On initial calendar render, this method is called first before any of the calendar is loaded
      // Additional pages of the calendar, this method is called after the events are cleared and the dates are changed but before the calendar day containers and next calendar events are reloaded.
      dayRender: function( date, cell ) { 
      },

      // On initial calendar render, this method is called before any of the calendar is loaded
      // Additional pages of the calendar, this method is called after the events are cleared, the dates are changed, and the day containers are loaded, but before the next calendar events are reloaded.
      viewRender: function (view) {

        // reset dates taken when rendering a new calendar range
        if (Kindrdfood.welcome.setAppointment.unavailableTimeSlots.length > 0) {
          $('#select-appt-cal').fullCalendar( 'removeEventSource', Kindrdfood.welcome.setAppointment.unavailableTimeSlots );
          Kindrdfood.welcome.setAppointment.unavailableTimeSlots = [];
          Kindrdfood.welcome.setAppointment.availableTimeSlots = [];
        }

        // moment of start date which is today
        var start_moment = moment(Kindrdfood.welcome.setAppointment.startDate());
        var today_moment = moment(new Date());

        // add disabled class to previous, next, or neither depending on range
        // if view.start is the same as today the hide previous button
        if (view.start.dayOfYear() === start_moment.dayOfYear() ) {
            $(".fc-prev-button").addClass('fc-state-disabled');
            $(".fc-next-button").removeClass('fc-state-disabled');

        // if vew.start is within 2 weeks then remove disabled on both
        } else if (view.start.dayOfYear() <= start_moment.dayOfYear() + 26){
          
          $(".fc-prev-button").removeClass('fc-state-disabled');
          $(".fc-next-button").removeClass('fc-state-disabled');

        // else add disabled to next
        } else{
        
          $(".fc-prev-button").removeClass('fc-state-disabled');
          $(".fc-next-button").addClass('fc-state-disabled');
        }
        
        // unbind next and prev disbaled button click event to shoew appt request modal
        $(".fc-next-button, .fc-prev-button").unbind('click.requestTimeHandler');

        // set click event for disabled next or previous button to show appt request form
        $(".fc-next-button.fc-state-disabled,  .fc-prev-button.fc-state-disabled").on("click.requestTimeHandler", function(e){
          e.preventDefault();
            $("#apptRequestModal").modal();
        });

        /// override head of calendar with TODAY or the date
        $(".fc-widget-header.fc-day-header").each(function(index){
          var split_date = $(this).text().split(" ");
          var day = split_date[0];
          var date = split_date[1];

          // if todays date then change title to say TODAY
          if ( moment(date).dayOfYear() === moment(new Date()).dayOfYear()){
            $(this).html("<p class='today-title'>TODAY</p><p>"+date+"</p>");
          } else { 
          // if not today's date then show date
            $(this).html("<p>"+day+"</p><p>"+date+"</p>");
          }
        });
      },

      // Initial calendar render, this method is called after the calendar container and dates are loaded but before any events have been loaded. Each event has this method called and then after all  of them have been called, then they display. 
      // Docs:  Triggered while an event is being rendered.
      eventRender: function(event, element) {

        var eventStart = event.start;

        // if event is an availabel time slot and not a time-slot-taken
        if (event.title != "time-slot-taken") {

          // add it to event start times rendered because it is an available time slot to choose from
          Kindrdfood.welcome.setAppointment.availableTimeSlots.push(eventStart.format());
        } 

        // remove fullcalendars default elements for events and add our own
        element.find(".fc-title").remove();
        element.find(".fc-time").remove();
        var new_html = "<div class='event-time'>​"+eventStart.format('h:mm A')+"</div>";
        $(element).children(":first").append(new_html);  

        // if the event is before 7 or after 11 then do not show
        if ( (eventStart.format("H") < 5) || (eventStart.format("H") > 23) ){

          return false;
        }
      
      },


      // Initial calendar render, this method is called after the calendar container and dates are loaded and after all events have been loaded to the screen.  
      // Docs: Triggered after an event has been placed on the calendar in its final position.
      eventAfterRender: function(event, element, view){
      },

      // Initial calendar render, this method is called after the calendar container and dates are loaded but before any events have been loaded to screen
      // Additional pages of the calendar, this method is called after the events are cleared, the dates are changed, and the day containers are loaded, but before the next calendar events are reloaded.
      // Docs:  After all events have finished rendering but have not been added to screen
      eventAfterAllRender: function( view, element){

        // check if taken time slots are created and if not then check all of the available time slot start times against all available times during the week to create the taken time slots
        
        if (Kindrdfood.welcome.setAppointment.unavailableTimeSlots.length < 1) {
          Kindrdfood.welcome.setAppointment.createUnavailableTimeSlots();
        }
      
      },

      // When any feeds are loading to calendar
      // Docs: Triggered when event fetching starts/stops.
      loading: function (isLoading) { 

        // if loading, hide calendar events, disabled next and previous button, and show spinner
        if (isLoading) { 
          $(".fc-day-grid-event").hide();
          $(".fc-prev-button, .fc-next-button").attr("disabled", true);
          $(".loading-spinner").show();

        // completed loading, enable next and previous button, hide spinner, and show calendar events
        } else {
          $(".fc-prev-button, .fc-next-button").attr("disabled", false);
          $(".loading-spinner").hide();
          $(".fc-day-grid-event").show();

        }
      },

      // When hovering over an event
      eventMouseover: function( event, jsEvent, view ) { 
        jsEvent.preventDefault();
     
        if (event.title === "time-slot-taken"){

        } else {

          $($(this).children(":first")).children(":first").text(event.start.format('h:mm')+" - "+event.end.format('h:mm A'));

        }
      },

      // When mouse exits hovering over an event
      eventMouseout: function( event, jsEvent, view ) { 
        jsEvent.preventDefault();

        if (event.title === "time-slot-taken"){

        } else {

          $($(this).children(":first")).children(":first").text(event.start.format('h:mm A'));
        }
      },

      // When clicking on an event
      eventClick: function(calEvent, jsEvent, view) {
        // on event click set up appointment by making AJAX call to edit_appointments_path
        jsEvent.preventDefault();
        $("#surveyApptModal").remove();
        var start = calEvent.start;
        var end = calEvent.end;
        var appt_id = $("#set-appt-time").data("appt-id")

        $.ajax({
           type: "GET",
           datatype: "json",
           data: {time_slot_id: calEvent.id},
           url: "/appointments/" + appt_id + "/purchases/new",
           success: function(response){
           } 
        });
      },
    });
  },
  setRequestTimeButton: function(){
    $("#request-appt-times").on("click", function(e){
      e.preventDefault();
        $("#apptRequestModal").modal();
    });
  },
  createUnavailableTimeSlots: function(){

    // loops through current date to +31 days and 7am to 11pm (23)
    for (var k = 0; k <= 31; k++){
      for(var i = 5; i<=23; i++){

        // create first date and time to check 
        var fullHourEvent = moment(moment(Kindrdfood.welcome.setAppointment.startDate()).add(k, "days").format("YYYY-MM-DD")+ " "+i+":00:00");

        // if date is not an available time slot then create time slot taken and add to dates taken
        if (Kindrdfood.welcome.setAppointment.availableTimeSlots.indexOf(fullHourEvent.format()) < 0){
          var date_object_1 = {
            title: 'time-slot-taken',
            start: fullHourEvent,
            editable: false,
            color: "lightgrey",
            className: "time-slot-taken",
            allDay: false // will make the time show
          };
          Kindrdfood.welcome.setAppointment.unavailableTimeSlots.push(date_object_1);
        };

        // if date is not an available time slot then create time slot taken and add to dates taken
        var halfHourEvent = moment(moment(Kindrdfood.welcome.setAppointment.startDate()).add(k, "days").format("YYYY-MM-DD")+ " "+i+":30:00");

        if (Kindrdfood.welcome.setAppointment.availableTimeSlots.indexOf(halfHourEvent.format()) < 0){
          var date_object_2 = {
            title  : 'time-slot-taken',
            start  : halfHourEvent,
            editable: false,
            color: "lightgrey",
            className: "time-slot-taken",
            allDay : false // will make the time show
          };
          Kindrdfood.welcome.setAppointment.unavailableTimeSlots.push(date_object_2);
        };
      };
    };

    // if there are dates taken then add events to calendar source
    if (Kindrdfood.welcome.setAppointment.unavailableTimeSlots.length >= 1){
      $('#select-appt-cal').fullCalendar( 'addEventSource', Kindrdfood.welcome.setAppointment.unavailableTimeSlots );
    }
 
  },
  setChangeTimeZone: function(){
    $('#user_time_zone').change(function() {
        this.form.submit();
    });
    $('#appointment_duration').change(function() {
        this.form.submit();
    });
  },
  setAppointmentDietitian: function(){
    // when radio button is changed
    $("input[name='appointment_dietitian']").on("change", function(){ 
      // get value of radio which is either the dietitian or blank string
      var dietitian_id = $(this).val();
      // fetch time slots with dietitian id as parameter
      $.ajax({
        url: '/time_slots.json',
        type: 'GET',
        data: {
          dietitian_id: dietitian_id, // send dietitian id to get specific dietitian schedule
        },
        // on success
        success: function(data){
          // remove current source, add new source and fetch events from updated source
          $('#select-appt-cal').fullCalendar('removeEventSource', '/time_slots.json' );
          $('#select-appt-cal').fullCalendar( 'addEventSource', data );
          $('#select-appt-cal').fullCalendar( 'refetchEvents' );
        },
        error: function() {
          alert('There was an error while fetching times.');
        },
      });
    })
  }
}
