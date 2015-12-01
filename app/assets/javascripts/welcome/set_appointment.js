
Kindrdfood = Kindrdfood || {};

Kindrdfood.welcome = Kindrdfood.welcome || {};

Kindrdfood.welcome.setAppointment = {

	init: function(){
    $("#request-appt-times").on("click", function(e){
      e.preventDefault();
      if ($("#apptRequestModal").length < 1){
          $.ajax({
            type: "GET",
            datatype: "script",
            url: "/appointments/new_appointment_request_times",
            success: function(response){
              $('.datetimepicker-appt-request').datetimepicker({ 
                  format: "MM/DD/YY h:mm a",
                  sideBySide: true });
              // make start and end calendars dependent upon eachother
              for (var count=1; count <= 3; count++){ 
                $('input[name="appointment['+count+'][start_time]"]').parent().on("dp.change",function (e) {
                  var requestNum = $(this).children("input").data("request-num");
                  $('input[name="appointment['+requestNum+'][end_time]"]').parent().data("DateTimePicker").setMinDate(e.date.add(1, "hours"));
                  $('input[name="appointment['+requestNum+'][end_time]"]').parent().data("DateTimePicker").setDate(e.date.add(1, "hours"));
                });
              };
            }
          });
      }else{
        $("#apptRequestModal").modal();
      }
    });
    // start date is set to today
    var start_date = new Date(); 
    start_date.setDate( start_date.getDate() + 0 );
    // get number of day, 1-7
    var start_day = start_date.getDay();
    // full calendar settings
    var event_start_times_rendered = [];
    var dates_taken = [];
    $('#select-appt-cal').fullCalendar({
      header: {
            left:   'prev',
            center: '',
            right:  'next'
      },
      views: {
        agendaThreeDay: {
            type: 'basic',
            duration: { days: 3 },
            buttonText: '3 day'
        }
      },
      defaultView: 'agendaThreeDay',
      // defaultDate: start_date,
      // firstDay: start_day,
      timezone: "local",
      events: {
        url: '/time_slots.json',
        type: 'GET',
        data: {
          // minutes: '60',
          type: 'vacant-appts'
        },
        error: function() {
          alert('there was an error while fetching events!');
        },
      },
      displayEventEnd: {
        month: false,
        agendaWeek: false,
        'default': false,
        agendaThreeDay: false
      },
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
      viewRender: function (view) {
        // reset dates taken when rendering a new calendar range
        if (dates_taken.length > 0) {
          $('#select-appt-cal').fullCalendar( 'removeEventSource', dates_taken );
          dates_taken = [];
        }
        // $('#select-appt-cal').fullCalendar( 'removeEventSource', dates_taken );
        // only enable next/prev button to go forward 1 week and return back to original week

        // moment of start date which is today
        var start_moment = moment(start_date);
        var today_moment = moment(new Date());

        // $(".fc-next-button.fc-state-disabled, .fc-prev-button.fc-state-disabled").unbind("click");


        if (view.start.dayOfYear() === start_moment.dayOfYear() ) {
            $(".fc-prev-button").addClass('fc-state-disabled');
            $(".fc-next-button").removeClass('fc-state-disabled');
        } else if (view.start.dayOfYear() === start_moment.dayOfYear()+14 ){
            $(".fc-prev-button").removeClass('fc-state-disabled');
            $(".fc-next-button").addClass('fc-state-disabled');
        }  else{
            $(".fc-prev-button").removeClass('fc-state-disabled');
            $(".fc-next-button").removeClass('fc-state-disabled');
        }
        
        // unbind next and prev disbaled button click event to shoew appt request modal
        $(".fc-next-button, .fc-prev-button").unbind('click.requestTimeHandler');
        // set click event for disabled next or previous button to show appt request form
        $(".fc-next-button.fc-state-disabled,  .fc-prev-button.fc-state-disabled").on("click.requestTimeHandler", function(e){
          e.preventDefault();
          if ($("#apptRequestModal").length < 1){
              $.ajax({
                type: "GET",
                datatype: "script",
                url: "/appointments/new_appointment_request_times",
                success: function(response){
                  $('.datetimepicker-appt-request').datetimepicker({ 
                      format: "MM/DD/YY h:mm a",
                      sideBySide: true });
                  // make start and end calendars dependent upon eachother
                  for (var count=1; count <= 3; count++){ 
                    $('input[name="appointment['+count+'][start_time]"]').parent().on("dp.change",function (e) {
                      var requestNum = $(this).children("input").data("request-num");
                      $('input[name="appointment['+requestNum+'][end_time]"]').parent().data("DateTimePicker").setMinDate(e.date.add(1, "hours"));
                      $('input[name="appointment['+requestNum+'][end_time]"]').parent().data("DateTimePicker").setDate(e.date.add(1, "hours"));
                    });
                  };
                }
              });
          }else{
            $("#apptRequestModal").modal();
          }
        });

        /// override head of calendar with TODAY or the date
        $(".fc-widget-header.fc-day-header").each(function(index){
          var split_date = $(this).text().split(" ");
          var day = split_date[0];
          var date = split_date[1];
          // if todays date then change title to say TODAY
          if (moment(date).date() === moment(new Date()).date()){
            $(this).html("<p class='today-title'>TODAY</p><p>"+date+"</p>");
          }else { 
          // if not today's date then show date
            $(this).html("<p>"+day+"</p><p>"+date+"</p>");
          }
        });

      },
      eventMouseover: function( event, jsEvent, view ) { 
        jsEvent.preventDefault();
     
        if (event.title === "time-slot-taken"){

        } else {
          $($(this).children(":first")).children(":first").text(event.start.format('h:mm')+" - "+event.end.format('h:mm A'));
          // $($(this).children(":first")).children(":first").addClass("hidden");
          // $($(this).children(":first")).append("<div class='appt-hover-text'>" + event.start.format('h:mm')+" - "+event.end.format('h:mma')+"</div>");
          // $(this).tooltip({placement: 'bottom', title: '<p>'+event.start.format('h:mm')+" - "+event.end.format('h:mma')+'</p>', html: true});
          // $(this).tooltip("show");
        }
      },
      eventMouseout: function( event, jsEvent, view ) { 
        jsEvent.preventDefault();
        if (event.title === "time-slot-taken"){

        } else {
          // $(".appt-hover-text").remove();
          $($(this).children(":first")).children(":first").text(event.start.format('h:mm A'));
          // $($(this).children(":first")).children(":first").removeClass("hidden");
          // $(this).tooltip("hide");
        }
      },
      eventClick: function(calEvent, jsEvent, view) {
        // on event click set up appointment by making AJAX call to edit_appointments_path
        jsEvent.preventDefault();
        $("#surveyApptModal").remove();
        var start = calEvent.start;
        var end = calEvent.end;
        var appt_id = $("#set-appt-time").data("appt-id")
        // $.ajax({
        //    type: "GET",
        //    datatype: "json",
        //    data: {time_slot_id: calEvent.id},
        //    url: "/appointments/"+appt_id+"/edit",
        //    success: function(response){
        //    } 
        // });
        $.ajax({
           type: "GET",
           datatype: "json",
           data: {time_slot_id: calEvent.id},
           url: "/appointments/" + appt_id + "/purchases/new",
           success: function(response){
           } 
        });
      },
      eventRender: function(event, element) {
        // remove fullcalendars default elements for events and add our own
          element.find(".fc-title").remove();
          element.find(".fc-time").remove();
        
          var new_html = "<div class='event-time'>​"+event.start.format('h:mm A')+"</div>";
          // $(element).children(":first").replaceWith(html);
          $(element).children(":first").append(new_html);
          // $(element).parent().hide();
          if (event.title != "time-slot-taken"){
            event_start_times_rendered.push(event.start.format());
          }

      },
      eventAfterRender: function(event, element, view){
        $(element).parent().hide();
      },
      dayRender: function( date, cell ) { 
        
      },
      eventAfterAllRender: function( view, element){
      

        $(".fc-event-container").fadeIn();
        if (dates_taken.length < 1) {
          // reset dates taken when rendering a new calendar range
          for (var k = 0; k <= 21; k++){
            for(var i = 7; i<=23; i++){
              var date = moment(moment(start_date).add(k, "days").format("YYYY-MM-DD")+ " "+i+":00:00");
              if (event_start_times_rendered.indexOf(date.format()) < 0 ){
                var date_object_1 = {
                  title: 'time-slot-taken',
                  start: date,
                  editable: false,
                  color: "lightgrey",
                  className: "time-slot-taken",
                  allDay: false // will make the time show
                };
                dates_taken.push(date_object_1);
              };
              var date_2 = moment(moment(start_date).add(k, "days").format("YYYY-MM-DD")+ " "+i+":30:00");
              if (event_start_times_rendered.indexOf(date_2.format()) < 0 ){
                var date_object_2 = {
                  title  : 'time-slot-taken',
                  start  : date_2,
                  editable: false,
                  color: "lightgrey",
                  className: "time-slot-taken",
                  allDay : false // will make the time show
                };
                dates_taken.push(date_object_2);
              };
            };
          };
          $('#select-appt-cal').fullCalendar( 'addEventSource', dates_taken );
        }
        // $(".time-slot-taken .event-time").text("Booked");
      }
    });
  }

}
