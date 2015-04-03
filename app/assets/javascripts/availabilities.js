var AvailabilityCalendar = {

  set: function(){
            // var new_events_array =[],
            // set_events_array=[], 
            // live_events_array=[], 
            // appointment_events_array=[],
    var new_events_hours_total=0,
        set_events_hours_total=0,
        live_events_hours_total=0,
        appointment_events_hours_total=0;
    $('#availability-cal').fullCalendar({
      header: {
          left: 'prev',
          center: 'today',
          right: 'next'
      },
      timezone: "local",
      events: '/availabilities.json',
      //   url: ,
      //   type: "GET",
      //   data: {id: optional_dietitian_id},
      //   error: function() {
      //     alert('there was an error while fetching events!');
      //   },
        
      // },
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
      select: function(start, end) {

        // check if selection is within time frame (for now, after today)
        var check = moment(start);
        var today = moment();
        if(check < today) {
          alert("Oops, add your availability with at least 24 hours notice!");
          $('#availability-cal').fullCalendar( 'unselect' );
            // So it will be unselectable
        // } else if (moment(end) <= moment(start).add(1, "hours").add(30, "minutes")) {

        } else {
          // if (moment(end) < moment(start).add(1, "hours").add(30, "minutes")){
          //   end = moment(start).add(1, "hours").add(30, "minutes");
          // }


          // after today then set availablility
          var eventData;
            eventData = {
              start: start,
              end: end,
              status: "New",
              editable: true,
              backgroundColor: "#F68D3C",
              borderColor: "#F16521",
            };
            $('#availability-cal').fullCalendar('renderEvent', eventData, true); // stick = true keeps the event even when the user changes calendar pages without saving the schedule
            // ajax call to save availablity
          $('#availability-cal').fullCalendar('unselect');

        }
      },
      eventMouseover: function( event, jsEvent, view ) { 
        jsEvent.preventDefault();
        if ( event.status === "Set"){
          $(this).addClass("hover-availability")
          // light orange background and border
          $(this).css("background-color", "#F68D3C");
          $(this).css("border-color", "#F16521");
          // add arrows above and below;
        } else if ( event.status === "New") {

        } else { // "Live"

        }

      },
      eventMouseout: function( event, jsEvent, view ) { 
        // this line was causing an error when deletng ann availability// it was saying undefined is not a funcion 
        // jsEvent.preventDefault();
        if ( event.status === "Set"){
          $(this).removeClass("hover-availability");
          // light green background        
          $(this).css("background-color", "#399E48");
          $(this).css("border-color", "#11753B");

        } else if ( event.status === "New") {

        } else { // "Live"

        }
      },
      eventClick: function(calEvent, jsEvent, view) {
        // on event click set up availability by making AJAX call 
        jsEvent.preventDefault();
        
        if ( calEvent.status === "New"){
          $('#availability-cal').fullCalendar('removeEvents', calEvent._id);
          new_events_hours_total -= 1;
        } else if ( calEvent.status === "Set") {  
                
          var availability_id = calEvent._id;
             
          $.ajax({
             type: "DELETE",
             datatype: "script",
             url: "/availabilities/"+availability_id,
             success: function(response){
              alert("deleted");
             } 
          });
             
          $('#availability-cal').fullCalendar('removeEvents', calEvent._id);
             
        } else { // "Live"
          var body_message = "Need to request a change to your schedule?  Explain the change here and we will contact you shortly!";
          var email = 'admin@kindrdfood.com';
          var subject = 'Update Schedule ' + calEvent.start._i;
          // Tara @kindrdfood.com
          var mailto_link = 'mailto:' + email + '?subject=' + subject + '&body=' + body_message;
          window.location.href = mailto_link;
        }
           
      },
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
              AvailabilityCalendar.set();
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
              AvailabilityCalendar.set();
            } 
          });
        }
      },
      eventAfterRender: function(event, element, view){
        // if (event.status === "Live"){ 
        //   live_events_hours_total += moment.duration(event.end - event.start);
        // } else if (event.status === "Set"){
        //   set_events_hours_total += moment.duration(event.end - event.start);
        // } else if (event.status === "Appointment"){
        //   appointment_events_total+= moment.duration(event.end - event.start);
        // } else {
        //   new_events_hours_total += moment.duration(event.end - event.start);
        // }
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
        // new_events_hours_total=0;
        // set_events_hours_total=0;
        // live_events_hours_total=0;
        // appointment_events_hours_total=0;
      },
      eventAfterAllRender: function(view){

        // $("#set-event-hours span").replaceWith("<span>"+(set_events_hours_total / 1000 / 60 / 60)+"</span>");
        // $("#new-event-hours span").replaceWith("<span>"+new_events_hours_total+"</span>");
        // $("#live-event-hours span").replaceWith("<span>"+(live_events_hours_total / 1000 / 60 / 60)+"</span>");
        // $("#appointment-event-hours span").replaceWith("<span>"+(appointment_events_hours_total / 1000 / 60 / 60)+"</span>");
      }
    });
    AvailabilityCalendar.set_save_button();
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
        AvailabilityCalendar.set();
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
             AvailabilityCalendar.set();
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
  }
}