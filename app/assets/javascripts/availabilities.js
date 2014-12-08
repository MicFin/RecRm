var AvailabilityCalendar = {

    // new user sign in form validations
    set: function(){
      $('#availability-cal').fullCalendar({
        header: {
            left: '',
            center: '',
            right: 'today prev,next'
        },
        timezone: "local",
        events: '/availabilities.json',
        displayEventEnd: {
          month: true,
          agendaWeek: true,
          'default': true
        },
        defaultView: 'agendaWeek',
        allDaySlot: false,
        allDayText: false,
        slotDuration: '00:15:00',
        minTime: "08:00:00",
        maxTime: "21:00:00",
        height: 500,
        eventBackgroundColor: "#399E48",
        eventBorderColor: "#11753B",
        editable: false,
        eventOverlap: false,
        selectable: true,
        selectHelper: true,
        selectOverlap: false,
        select: function(start, end) {
          // check if selection is within time frame (for now, after today)
          var check = moment(start);
          var today = moment();
          if(check < today) {
              // Previous Day. show message if you want otherwise do nothing.
              // So it will be unselectable
          } else {
            // after today then set availablility
            var title = prompt('Event Title:');
            var eventData;
            if (title) {
              eventData = {
                title: title,
                start: start,
                end: end,
                status: "New",
                editable: true,
                backgroundColor: "#F68D3C",
                borderColor: "#F16521"
              };
              $('#availability-cal').fullCalendar('renderEvent', eventData, true); // stick = true keeps the event even when the user changes calendar pages without saving the schedule
              // ajax call to save availablity
            }
            $('#availability-cal').fullCalendar('unselect');
          }
        },
        // eventResize: function(event, delta, revertFunc) {
        //   debugger;
        //   if (event.status != "New") {
        //       revertFunc();
        //   }

        // },
        // eventMouseover: function( event, jsEvent, view ) { 
        //   jsEvent.preventDefault();
        //   $(this).removeClass("fc-event");
        //   $(this).addClass("appt-hover-bg");
        //   $(this).children(":first").addClass("hidden");
        //   $(this).append("<div class='appt-hover-text'>​Select</div>");
        //   $(this).tooltip({placement: 'bottom', title: '<p>'+event.start.format('h:mm')+" - "+event.end.format('h:mma')+'</p>', html: true});
        // },
        // eventMouseout: function( event, jsEvent, view ) { 
        //   jsEvent.preventDefault();
        //   $(".appt-hover-text").remove();
        //   $(this).removeClass("appt-hover-bg");
        //   $(this).addClass("fc-event");
        //   $(this).children(":first").removeClass("hidden");
        // },
        // eventClick: function(calEvent, jsEvent, view) {
        //   // on event click set up appointment by making AJAX call to edit_appointments_path
        //   jsEvent.preventDefault();
        //   $("#surveyApptModal").remove();
        //   var start = calEvent.start;
        //   var end = calEvent.end;
        //   var appt_id = $("#set-appt-time").data("appt-id")
        //   $.ajax({
        //      type: "GET",
        //      datatype: "json",
        //      data: {time_slot_id: calEvent.id},
        //      url: "/appointments/"+appt_id+"/edit",
        //      success: function(response){
        //      } 
        //   });
        // },
        eventRender: function(event, element) {
          // remove fullcalendars default elements for events and add our own
          element.find(".fc-event-title").remove();
          element.find(".fc-event-time").remove();
          var new_html = "<div class='event-time'>​"+event.start.format('h:mm')+" - "+event.end.format('h:mma')+"</div>";
          // $(element).children(":first").replaceWith(html);
          $(element).children(":first").append(new_html);

        }
      });
      AvailabilityCalendar.set_save_button();
    },
    set_save_button: function(){
      $("#save-schedule-button").on("click", function(e){
        e.preventDefault();
        var clean_availabilities = [];
        var raw_availabilities = $('#availability-cal').fullCalendar( 'clientEvents');
        var new_availabilities = $.grep(raw_availabilities, function(e){ return e.status == "New"; });
        if (new_availabilities.length >= 1){
          $.each(new_availabilities, function(key, availability){
            clean_availabilities.push({start_time: availability.start.format(), end_time: availability.end.format(), buffered_start_time: availability.start.add(15, "minutes").format(), buffered_end_time: availability.end.subtract(15, "minutes").format()});
          });
          $.ajax({
            type: "POST",
            datatype: "script",
            data: {availabilities: clean_availabilities},
            url: "/availabilities/set_schedule",
            success: function(response){
               $("#availability-cal").replaceWith("<div class='col-xs-6 col-xs-offset-3' id='availability-cal'></div>");
               AvailabilityCalendar.set();
             } 
          });
        } else {
          alert("Please add to your schedule then save again");
        };
      });
    }
}