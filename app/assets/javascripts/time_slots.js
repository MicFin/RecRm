

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