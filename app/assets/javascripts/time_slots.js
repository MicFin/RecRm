

var TimeSlotCalendar = {
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
  set: function(){
    $("#request-appt-times").on("click", function(e){
      e.preventDefault();
          $.ajax({
            type: "GET",
            datatype: "script",
            url: "/appointments/new_appointment_request_times",
            success: function(response){
              $('.datetimepicker-appt-request').datetimepicker({ 
                  format: "MM/DD/YY h:mm a",
                  sideBySide: true });
            }
          });
    });
    var start_date = new Date(); 
    start_date.setDate( start_date.getDate() + 0 );
    var start_day = start_date.getDay();
    // full calendar settings
    var event_start_times_rendered = [];
    var dates_taken = [];
    $('#select-appt-cal').fullCalendar({
      header: {
            left:   '',
            center: 'prev',
            right:  'next'
      },
      defaultDate: start_date,
      firstDay: start_day,
      timezone: "local",
      events: {
        url: '/time_slots.json',
        type: 'GET',
        data: {
          minutes: '60',
          type: 'vacant-appts'
        },
        error: function() {
          alert('there was an error while fetching events!');
        },
      },
      displayEventEnd: {
        month: false,
        agendaWeek: false,
        'default': false
      },
      defaultView: 'basicWeek',
      allDaySlot: false,
      allDayText: false,
      slotDuration: '00:30:00',
      minTime: "08:00:00",
      maxTime: "21:00:00",
      columnFormat: 'ddd M/DD/YY',
      height: 500,
      eventBackgroundColor: "#399E48",
      eventBorderColor: "#11753B",
      viewRender: function (view) {
        // only enable next/prev button to go forward 1 week and return back to original week
        var start_moment = moment(start_date);
        var today_moment = moment(new Date());
        if (view.start.dayOfYear() === start_moment.dayOfYear() ) {
            $(".fc-prev-button").addClass('fc-state-disabled');
            $(".fc-next-button").removeClass('fc-state-disabled');
        }
        else {
            $(".fc-prev-button").removeClass('fc-state-disabled');
            $(".fc-next-button").addClass('fc-state-disabled');
        }  
        $(".fc-widget-header.fc-day-header").each(function(index){
          var split_date = $(this).text().split(" ");
          var day = split_date[0];
          var date = split_date[1];
          if (moment(date).date() === moment(new Date()).date()){
            $(this).html("<p class='today-title'>TODAY</p><p>"+date+"</p>");
          }else { 
            $(this).html("<p>"+day+"</p><p>"+date+"</p>");
          }
        });

      },
      eventMouseover: function( event, jsEvent, view ) { 
        jsEvent.preventDefault();
     
        if (event.title === "time-slot-taken"){

        } else {
          $($(this).children(":first")).children(":first").text(event.start.format('h:mm')+" - "+event.end.format('h:mma'));
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
          $($(this).children(":first")).children(":first").text(event.start.format('h:mma'));
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
          element.find(".fc-title").remove();
          element.find(".fc-time").remove();
        
          var new_html = "<div class='event-time'>​"+event.start.format('h:mm a')+"</div>";
          // $(element).children(":first").replaceWith(html);
          $(element).children(":first").append(new_html);
          $(element).parent().hide();
          event_start_times_rendered.push(event.start.format());
      },
      eventAfterRender: function(event, element, view){
        $(element).parent().hide();
      },
      dayRender: function( date, cell ) { 
        
      },
      eventAfterAllRender: function( view, element){
        $(".fc-event-container").fadeIn();
        if (dates_taken.length < 1) {
          for (var k = 0; k <= 21; k++){
            for(var i = 8; i<=24; i++){
              date = moment(moment(start_date).add(k, "days").format("YYYY-MM-DD")+ " "+i+":00:00");
              if (event_start_times_rendered.indexOf(date.format()) < 0 ){
                date_object = {
                  title: 'time-slot-taken',
                  start: date,
                  editable: false,
                  color: "lightgrey",
                  className: "time-slot-taken",
                  allDay: false // will make the time show
                };
                dates_taken.push(date_object);
              };
              date = moment(moment(start_date).add(k, "days").format("YYYY-MM-DD")+ " "+i+":30:00");
              if (event_start_times_rendered.indexOf(date.format()) < 0 ){
                date_object = {
                  title  : 'time-slot-taken',
                  start  : date,
                  editable: false,
                  color: "lightgrey",
                  className: "time-slot-taken",
                  allDay : false // will make the time show
                };
                dates_taken.push(date_object);
              };
            };
          };
          $('#select-appt-cal').fullCalendar( 'addEventSource', dates_taken );
        };
        $(".time-slot-taken .event-time").text("Booked");
      }
    });
  

  }
};

var TimeSlotsDetailedCalenders = {

  set_half_hour_calendar: function(){

    var halfHourEventCounter;
    $("#half-hour-time-slot-button").on("click", function(e){
      e.preventDefault();
      if ($("#half-hour-time-slot-cal-container").hasClass("hidden")){
        $(".time-slot-cal-container").addClass("hidden");
        $("#half-hour-time-slot-cal-container").removeClass("hidden");
        TimeSlotsDetailedCalenders.set_half_hour_calendar();
      }
    });
    $("#half-hour-time-slots-cal").fullCalendar({
      header: {
            left:   '',
            center: '',
            right:  'prev,next'
      },
      timezone: "local",
      height: 500,
      defaultView: 'agendaWeek',
      slotDuration: '00:15:00',
      minTime: "08:00:00",
      maxTime: "21:00:00",
      events: {
        url: '/time_slots.json',
        type: 'GET',
        data: {
            minutes: '30',
            type: "Review"
        },
        error: function() {
            alert('there was an error while fetching events!');
        },
      },
      eventRender: function(event, element) {
        // remove fullcalendars default elements for events and add our own
        if (event.start._i in halfHourEventCounter){
          // increase time slot counter
          halfHourEventCounter[event.start._i]["count"] += 1;
          halfHourEventCounter[event.start._i]["description"] += ", "+event.description;
          return false;
        } else {
          halfHourEventCounter[event.start._i] = {"count": 1, "id": event.id, "description": event.description};
          var $eventElement = element.find(".fc-time span").first();
          var new_html = 
            "<span id='half-hour-"+halfHourEventCounter[event.start._i]["id"]+"' class='event-time'>​" + 
            halfHourEventCounter[event.start._i]["count"] +
          "</span>";
          $eventElement.replaceWith(new_html);
        }
      },
      viewRender: function( view, element){
        halfHourEventCounter = {};
      },
      eventAfterAllRender: function( view, element){
        for (var key in halfHourEventCounter) {
          var obj = halfHourEventCounter[key];
          var $eventElement = $("#half-hour-"+obj["id"]);

          var new_html = 
          "<span id='half-hour-"+obj["id"]+"' class='event-time'>​" + obj["count"] + "</span>";
          $eventElement.replaceWith(new_html);
          $("#half-hour-"+obj["id"]).parent().parent().parent().attr("data-toggle", "tooltip").attr("data-placement", "top").attr("title", obj["description"]).tooltip();
        }
      }    
    })
  },
  set_one_hour_calendar: function(){
    var oneHourEventCounter;
    $("#one-hour-time-slot-button").on("click", function(e){
      e.preventDefault();
      if ($("#one-hour-time-slot-cal-container").hasClass("hidden")){
        $(".time-slot-cal-container").addClass("hidden");
        $("#one-hour-time-slot-cal-container").removeClass("hidden");
        TimeSlotsDetailedCalenders.set_one_hour_calendar();
      }
    });
    $("#one-hour-time-slots-cal").fullCalendar({
      timezone: "local",
      header: {
            left:   '',
            center: '',
            right:  'prev,next'
      },
      height: 500,
      defaultView: 'agendaWeek',
      slotDuration: '00:30:00',
      minTime: "08:00:00",
      maxTime: "21:00:00",
      events: {
        url: '/time_slots.json',
        type: 'GET',
        data: {
            minutes: '60',
            type: "Review",
        },
        error: function() {
            alert('there was an error while fetching events!');
        }
      },
      eventRender: function(event, element) {
        // remove fullcalendars default elements for events and add our own
        if ( event.start._i in oneHourEventCounter){
          oneHourEventCounter[event.start._i]["count"] += 1;
          oneHourEventCounter[event.start._i]["description"] += ", "+event.description;
          return false;
        } else {
          oneHourEventCounter[event.start._i] = {"count": 1, "id": event.id, "description": event.description};
          var $eventElement = element.find(".fc-time span").first();
          var new_html = 
            "<span id='one-hour-"+oneHourEventCounter[event.start._i]["id"]+"' class='event-time' data-toggle='tooltip' data-placement='top' title='"+ oneHourEventCounter[event.start._i]["description"] +"'>​" + 
            oneHourEventCounter[event.start._i]["count"] +
          "</span>";
          $eventElement.replaceWith(new_html);
        }
      },
      viewRender: function( view, element){
        oneHourEventCounter = {};
      },
      eventAfterAllRender: function( view, element){
        for (var key in oneHourEventCounter) {
          var obj = oneHourEventCounter[key];
          var $eventElement = $("#one-hour-"+obj["id"]);

          var new_html = 
            "<span id='one-hour-"+obj["id"]+"' class='event-time'>​" + 
            obj["count"] +
          "</span>";
          $eventElement.replaceWith(new_html);
          $("#one-hour-"+obj["id"]).parent().parent().parent().attr("data-toggle", "tooltip").attr("data-placement", "top").attr("title", obj["description"]).tooltip();
          /////// PERSONALIZING TOOLTIP
          // var toolTipArray = obj["description"].split(",");
          // var toolTipString = "";
          // for (var i = 0; i < toolTipArray.length; i++){
          //   toolTipString += "<p>"+toolTipArray[i]+"</p>";
          // }
          // var toolTipTemplate = 
          //   "<div class='tooltip' role='tooltip'>"+
          //     "<div class='tooltip-arrow'>" +
          //     "</div>" + 
          //     "<div class='tooltip-inner'>" +
          //       toolTipString +
          //     "</div>" +
          //   "</div>";
          // $("#one-hour-"+obj["id"]).parent().parent().parent().attr("data-toggle", "tooltip").attr("data-placement", "top").attr("title", toolTipTemplate).attr("html","true").tooltip();
        }
      }  
    })
  },
  set_half_and_one_hour_calendars: function(){
    this.set_half_hour_calendar();
    this.set_one_hour_calendar();
    $("#one-hour-time-slot-cal-container").addClass("hidden");
    $("#availability-cal-container").addClass("hidden");
    $("#appointments-cal-container").addClass("hidden");
    $("#dietitian-availability-button").on("click", function(e){
      e.preventDefault();
      var dietitian_id = $("#select-dietitian").val();
      $(".time-slot-cal-container").addClass("hidden");
      $("#availability-cal-container").removeClass("hidden");
      AvailabilityCalendar.review(dietitian_id);
      $("#availability-cal-container h1").text($("#select-dietitian option:selected" ).text());
    });
    $("#appointments-time-slot-button").on("click", function(e){
      e.preventDefault();
      $(".time-slot-cal-container").addClass("hidden");
      $("#appointments-cal-container").removeClass("hidden");
      AppointmentsCalender.review();
    });
  }
}