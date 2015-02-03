var AvailabilityCalendar = {

  set: function(){
    $('#availability-cal').fullCalendar({
      header: {
          left: '',
          center: '',
          right: 'today prev,next'
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
      minTime: "08:00:00",
      maxTime: "21:00:00",
      height: 500,
      eventBackgroundColor: "#399E48",
      eventBorderColor: "#11753B",
      editable: true,
      eventOverlap: false,
      selectable: false,
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
          var eventData;
            eventData = {
              start: start,
          // override default end time since on dayClick I couldn't pass the 1 hour end time
              // end: end,
              end: check.add(15, "minutes"),
              status: "New",
              editable: true,
              backgroundColor: "#F68D3C",
              borderColor: "#F16521"
            };
            $('#availability-cal').fullCalendar('renderEvent', eventData, true); // stick = true keeps the event even when the user changes calendar pages without saving the schedule
            // ajax call to save availablity
          $('#availability-cal').fullCalendar('unselect');
        }
      },
      // eventResize: function(event, delta, revertFunc) {
      //   
      //   if (event.status != "New") {
      //       revertFunc();
      //   }

      // },
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
      dayClick: function(date, jsEvent, view) {
        var today = moment();
        if (date > today.add(1, "days") ) {
          $('#availability-cal').fullCalendar('select', date);
          // alert('Clicked on: ' + date.format());

          // alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);

          // alert('Current view: ' + view.name);
        } else {
          alert("All new available time slots must be at least 24 hours from now.");
        }
      },
      eventClick: function(calEvent, jsEvent, view) {
        // on event click set up availability by making AJAX call 
        jsEvent.preventDefault();
        
        if ( calEvent.status === "New"){
          $('#availability-cal').fullCalendar('removeEvents', calEvent._id);
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
          var mailto_link = 'mailto:' + email + '?subject=' + subject + '&body=' + body_message;
          window.location.href = mailto_link;
        }
           
      },
      eventResize: function (event, delta, revertFunc, jsEvent, ui, view){

        if (event.status === "Set"){
          // light orange
          event.backgroundColor = "#F68D3C";
          event.borderColor = "#F16521";
          event.status = "Updated";
          // element.css("background-color", "gray").css("border-color", "gray");
        }
      },
      eventDrop: function (event, delta, revertFunc, jsEvent, ui, view){

        if (event.status === "Set"){
          // light orange
          event.backgroundColor = "#F68D3C";
          event.borderColor = "#F16521";
          event.status = "Updated";
          // element.css("background-color", "gray").css("border-color", "gray");
        }
      },
      eventRender: function(event, element) {
        // remove fullcalendars default elements for events and add our own
        element.find(".fc-time span").remove();
        element.attr('id', event.id);
        var new_html = "<div class='col-xs-12'><span class='glyphicon glyphicon-trash'></span></div><div class='event-time'>​"+event.start.format('h:mm')+" - "+event.end.format('h:mma')+"</div>";
        if (event.status === "Live"){
          element.css("background-color", "gray").css("border-color", "gray");
        }
        // $(element).children(":first").replaceWith(html);
        $(element).children(":first").append(new_html);
      }
    });
    AvailabilityCalendar.set_save_button();
  },
  set_save_button: function(){
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
               $("#availability-cal").replaceWith("<div class='col-xs-8' id='availability-cal'></div>");
               AvailabilityCalendar.set();
             } 
          });
        }
        $("#availability-cal").replaceWith("<div class='col-xs-8' id='availability-cal'></div>");
        AvailabilityCalendar.set();
      } else if (updated_availabilities.length >= 1){
        $.each(updated_availabilities, function(key, availability){
          clean_updated_availabilities.push({id: availability.id, start_time: availability.start.format(), end_time: availability.end.format(), buffered_start_time: availability.start.add(15, "minutes").format(), buffered_end_time: availability.end.subtract(15, "minutes").format()});
        });
        $.ajax({
          type: "PATCH",
          datatype: "script",
          data: {availabilities: clean_updated_availabilities},
          url: "/availabilities/update_schedule",
          success: function(response){
             $("#availability-cal").replaceWith("<div class='col-xs-8' id='availability-cal'></div>");
             AvailabilityCalendar.set();
           } 
        });
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