
Kindrdfood = Kindrdfood || {};

Kindrdfood.availabilities = Kindrdfood.availabilities || {};

Kindrdfood.availabilities.index = {

  init: function(){
  	this.set();
  	this.setButtons();
  },

  // calendar used for viewing or editing dietitian schedule
  set: function(){
    $('#availability-cal').fullCalendar({
      header: {
          left: 'prev',
          center: 'today',
          right: 'next'
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
      minTime: "06:45:00",
      maxTime: "24:00:00",
      height: 450,
      eventBackgroundColor: "#399E48",
      eventBorderColor: "#11753B",
      editable: true,
      eventOverlap: false,
      selectable: true,
      selectHelper: true,
      selectOverlap: false,

      // When a user selects a space on the calendar
      select: function(start, end) {

        // check if selection is within time frame (for now, after today)
        var check = moment(start);
        var today = moment();

        // If less than a days notice than alert and unselect calendar
        if(check < today) {
          alert("Oops, add your availability with at least 24 hours notice!");
          $('#availability-cal').fullCalendar( 'unselect' );

        // If the selection is great than 24 hours then set availability
        } else {
          var eventData;
          eventData = {
            start: start,
            end: end,
            status: "New",
            editable: true,
            backgroundColor: "#F68D3C",
            borderColor: "#F16521",
          };
          // stick = true keeps the event even when the user changes calendar pages without saving the schedule
          $('#availability-cal').fullCalendar('renderEvent', eventData, true); 
          $('#availability-cal').fullCalendar('unselect');

        }
      },

      // When user mouses over an event
      eventMouseover: function( event, jsEvent, view ) { 
        jsEvent.preventDefault();

        // If the event is a set event (not New or Live)
        if ( event.status === "Set") {
          $(this).addClass("hover-availability")
          // light orange background and border
          $(this).css("background-color", "#F68D3C");
          $(this).css("border-color", "#F16521");
        } 
      },

      // When the user removes mouse from a mouse over event
      eventMouseout: function( event, jsEvent, view ) { 
        // this line was causing an error when deletng an availability// it was saying undefined is not a funcion 
        // jsEvent.preventDefault();

        // If the event is a set event (not New or Live)
        if ( event.status === "Set") {
          $(this).removeClass("hover-availability");
          // light green background        
          $(this).css("background-color", "#399E48");
          $(this).css("border-color", "#11753B");

        } 
      },

      // When the user clicks on an event
      eventClick: function(calEvent, jsEvent, view) {
        
        jsEvent.preventDefault();
        
        // If event is New then remove the event
        if ( calEvent.status === "New"){
          $('#availability-cal').fullCalendar('removeEvents', calEvent._id);

        // Else if event is Set then
        } else if ( calEvent.status === "Set") {  
                
          var availability_id = calEvent._id;
           
          // Make Ajax call to delete availability
          $.ajax({
						type: "DELETE",
						datatype: "script",
						url: "/availabilities/"+availability_id,
						success: function(response){
							alert("deleted");
            } 
          });
          
          // Then remove the event
          $('#availability-cal').fullCalendar('removeEvents', calEvent._id);
        
        // Else the event is Live
        } else { 

        	// Email admin to cancel Live available time slot
          var body_message = "Need to request a change to your schedule?  Explain the change here and we will contact you shortly!";
          var email = 'admin@kindrdfood.com';
          var subject = 'Update Schedule ' + calEvent.start._i;
          // Tara @kindrdfood.com
          var mailto_link = 'mailto:' + email + '?subject=' + subject + '&body=' + body_message;
          window.location.href = mailto_link;
        }
           
      },

      // When the user resizes an event
      eventResize: function (event, delta, revertFunc, jsEvent, ui, view){
        if (event.status === "Set"){
          var updated_event_array = [];
          var start_time = event.start.format();
          var end_time = event.end.format();
          var buffered_end_time = event.end.subtract(15, "minutes").format();
          var buffered_start_time = event.start.add(15, "minutes").format();
          var updatedEventObject = {
              id: event.id, 
              start_time: start_time, 
              end_time: end_time, 
              buffered_start_time: buffered_start_time,
              buffered_end_time: buffered_end_time
          };
          updated_event_array.push(updatedEventObject);
          $.ajax({
            type: "PATCH",
            datatype: "script",
            data: {availabilities: updated_event_array},
            url: "/availabilities/update_schedule",
            success: function(response){
              $("#availability-cal").replaceWith("<div class='col-xs-8' id='availability-cal'></div>");
              Kindrdfood.availabilities.index.set();
            } 
          });
        }
      },
      eventDrop: function (event, delta, revertFunc, jsEvent, ui, view){

        if (event.status === "Set"){
          var updated_event_array = [];
          var start_time = event.start.format();
          var end_time = event.end.format();
          var buffered_end_time = event.end.subtract(15, "minutes").format();
          var buffered_start_time = event.start.add(15, "minutes").format();
          var updatedEventObject = {
              id: event.id, 
              start_time: start_time, 
              end_time: end_time, 
              buffered_start_time: buffered_start_time,
              buffered_end_time: buffered_end_time
          };
          updated_event_array.push(updatedEventObject);
          $.ajax({
            type: "PATCH",
            datatype: "script",
            data: {availabilities: updated_event_array},
            url: "/availabilities/update_schedule",
            success: function(response){
              $("#availability-cal").replaceWith("<div class='col-xs-8' id='availability-cal'></div>");
              Kindrdfood.availabilities.index.set();
            } 
          });
        }
      },
      eventAfterRender: function(event, element, view){

      },
      eventRender: function(event, element) {
        // remove fullcalendars default elements for events and add our own
        event.overlap = false;
        element.find(".fc-time span").remove();
        element.attr('id', event.id);
        var new_html = "<div class='col-xs-12'><span class='glyphicon glyphicon-trash'></span></div><div class='event-time'>​"+event.start.format('h:mm')+" - "+event.end.format('h:mma')+"</div>";
        if (event.status === "Live"){
          element.css("background-color", "gray").css("border-color", "gray");
        }
        // $(element).children(":first").replaceWith(html);
        $(element).children(":first").append(new_html);
      },
      viewRender: function(view, element){
      },
      eventAfterAllRender: function(view){
      }
    });
    Kindrdfood.availabilities.index.set_save_button();
  },
  set_save_button: function(){
    $("#save-schedule-button").unbind("click");
    $("#save-schedule-button").on("click", function(e){
      e.preventDefault();

      var clean_new_availabilities = [];
      var clean_updated_availabilities = [];
      var raw_availabilities = $('#availability-cal').fullCalendar( 'clientEvents');
      var new_availabilities = $.grep(raw_availabilities, function(e){ return e.status == "New"; });
      var updated_availabilities = $.grep(raw_availabilities, function(e){ return e.status == "Updated"; });
      if (new_availabilities.length >= 1){
        $.each(new_availabilities, function(key, availability){
          clean_new_availabilities.push({start_time: availability.start.format(), end_time: availability.end.format(), buffered_start_time: availability.start.add(15, "minutes").format(), buffered_end_time: availability.end.subtract(15, "minutes").format()});
        });
        $.ajax({
          type: "POST",
          datatype: "script",
          data: {availabilities: clean_new_availabilities},
          url: "/availabilities/set_schedule",
          success: function(response){
           } 
        });
        if (updated_availabilities.length >= 1){
          $.each(updated_availabilities, function(key, availability){
            clean_updated_availabilities.push({id: availability.id, start_time: availability.start.format(), end_time: availability.end.format(), buffered_start_time: availability.start.add(15, "minutes").format(), buffered_end_time: availability.end.subtract(15, "minutes").format()});
          });
          $.ajax({
            type: "PATCH",
            datatype: "script",
            data: {availabilities: clean_updated_availabilities},
            url: "/availabilities/update_schedule",
            success: function(response){
             } 
          });
        }
        $("#availability-cal").replaceWith("<div class='col-xs-8' id='availability-cal'></div>");
        Kindrdfood.availabilities.index.set();
      } else if (updated_availabilities.length >= 1){
        $.each(updated_availabilities, function(key, availability){
          if (availability.end.diff(availability.start, 'minutes') < 90) {
            alert("Please save at least 1 1/2 hours in a row.");
            return;
          };
          clean_updated_availabilities.push({id: availability.id, start_time: availability.start.format(), end_time: availability.end.format(), buffered_start_time: availability.start.add(15, "minutes").format(), buffered_end_time: availability.end.subtract(15, "minutes").format()});
        });
        $.ajax({
          type: "PATCH",
          datatype: "script",
          data: {availabilities: clean_updated_availabilities},
          url: "/availabilities/update_schedule",
          success: function(response){
           } 
        });
        $("#availability-cal").replaceWith("<div class='col-xs-8' id='availability-cal'></div>");
             Kindrdfood.availabilities.index.set();
      } else {
        alert("Please add to or update your schedule then save again");
      };

    });
  },
  review: function(dietitian_id){
    $('#availability-cal').replaceWith("<div id='availability-cal'></div>");
    $('#availability-cal').fullCalendar({
      header: {
          left: '',
          center: '',
          right: 'today prev,next'
      },
      timezone: "local",
      // events: '/availabilities.json',
      eventSources: [
        {
          url: '/availabilities.json',
          type: "GET",
          async:false,
          data: {
            dietitian_id: dietitian_id
          },
          error: function() {
            alert('there was an error while fetching events!');
          }
        },
        {
          url: '/appointments.json',
          type: "GET",
          async:false,
          data: {
            dietitian_id: dietitian_id
          },
          error: function() {
            alert('there was an error while fetching events!');
          }
        }
      ],
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
      eventRender: function(event, element) {
        // remove fullcalendars default elements for events and add our own
        element.find(".fc-time span").remove();
        element.attr('id', event.id);
        var new_html = "<div class='col-xs-12'></div><div class='event-time'>​"+event.start.format('h:mm')+" - "+event.end.format('h:mma')+"</div>";
        if (event.status === "Live"){
          element.css("background-color", "gray").css("border-color", "gray");
        }
        // $(element).children(":first").replaceWith(html);
        $(element).children(":first").append(new_html);
      }
    });
  },
	setButtons: function(){
    $(".assign-appointment-request").on("click", function(e){
      e.preventDefault();
      var appt_id = $(this).closest(".appt-id").data("appt-id");
      var data = {data: "Request"};
      $.ajax({
        type: "GET",
        datatype: "script",
        data: data,
        url: "/appointments/"+appt_id,
        success: function(response){
        } 
      })
    });
	}
}