

var TimeSlotCalendar = {
    // new user sign in form validations
    set: function(){
		  $('#calendar').fullCalendar({
        timezone: "local",
			 events: '/time_slots.json'
		  });
	  },
    initiate_date_time_picker:function () {
        $('#datetimepicker-appt-start').datetimepicker({ dateFormat: 'D, dd M yy' });
        $('#datetimepicker-appt-end').datetimepicker({ dateFormat: 'D, dd M yy' });
        $("#datetimepicker-appt-start").on("dp.change",function (e) {
           $('#datetimepicker-appt-end').data("DateTimePicker").setMinDate(e.date);
           $('#datetimepicker-appt-end').data("DateTimePicker").setDate(e.date);
        });
        $("#datetimepicker-appt-end").on("dp.change",function (e) {
           $('#datetimepicker-appt-start').data("DateTimePicker").setMaxDate(e.date);
        });
    }
};


var SelectApptCalendar = {

    // new user sign in form validations
    set: function(){
      var start_date = new Date(); 
      start_date.setDate( start_date.getDate() + 2 );
      var start_day = start_date.getDay();
      // full calendar settings
      $('#select-appt-cal').fullCalendar({
        header: {
              left:   '',
              center: '',
              right:  'prev,next'
        },
        defaultDate: start_date,
        firstDay: start_day,
        timezone: "local",
        events: '/time_slots.json',
        displayEventEnd: {
          month: true,
          agendaWeek: true,
          'default': true
        },
        defaultView: 'agendaWeek',
        allDaySlot: false,
        allDayText: false,
        minTime: "08:00:00",
        maxTime: "21:00:00",
        height: 500,
        eventBackgroundColor: "#399E48",
        eventBorderColor: "#11753B",
        viewRender: function (view) {
          // only enable next/prev button to go forward 1 week and return back to original week
          var start_moment = moment(start_date);
          var today_moment = moment(new Date());
          if (view.start.dayOfYear() === start_moment.dayOfYear() ) {
              $(".fc-button-prev").addClass('fc-state-disabled');
              $(".fc-button-next").removeClass('fc-state-disabled');
          }
          else {
              $(".fc-button-prev").removeClass('fc-state-disabled');
              $(".fc-button-next").addClass('fc-state-disabled');
          }  
        },
        eventMouseover: function( event, jsEvent, view ) { 
          jsEvent.preventDefault();
          $(this).removeClass("fc-event");
          $(this).addClass("appt-hover-bg");
          $(this).children(":first").addClass("hidden");
          $(this).append("<div class='appt-hover-text'>​Select</div>");
          $(this).tooltip({placement: 'bottom', title: '<p>'+event.start.format('h:mm')+" - "+event.end.format('h:mma')+'</p>', html: true});
        },
        eventMouseout: function( event, jsEvent, view ) { 
          jsEvent.preventDefault();
          $(".appt-hover-text").remove();
          $(this).removeClass("appt-hover-bg");
          $(this).addClass("fc-event");
          $(this).children(":first").removeClass("hidden");
        },
        eventClick: function(calEvent, jsEvent, view) {
          // on event click set up appointment by making AJAX call to edit_appointments_path
          jsEvent.preventDefault();
          var start = calEvent.start;
          var end = calEvent.end;
          var appt_id = $("#set-appt-time").data("appt-id")
          $.ajax({
             type: "GET",
             datatype: "json",
             data: {time_slot_id: calEvent.id},
             url: "/appointments/"+appt_id+"/edit",
             success: function(response){
             } 
          });
        },
        eventRender: function(event, element) {
          // remove fullcalendars default elements for events and add our own
          element.find(".fc-event-title").remove();
          element.find(".fc-event-time").remove();
          var new_html = "<div class='event-time'>​"+event.start.format('h:mm')+" - "+event.end.format('h:mma')+"</div>";
          // $(element).children(":first").replaceWith(html);
          $(element).children(":first").append(new_html);

        }
      })
    }
}