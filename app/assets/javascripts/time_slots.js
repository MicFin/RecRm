

var TimeSlotCalendar = {
    // new user sign in form validations
    set: function(){
		$('#calendar').fullCalendar({
      timezone: "local",
			events: '/time_slots.json'
		});
	},
    initiate_date_time_picker:function () {
        $('#datetimepicker-appt-start').datetimepicker();
        $('#datetimepicker-appt-end').datetimepicker();
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
    $('#select-appt-cal').fullCalendar({
      timezone: "local",
      events: '/time_slots.json',
      defaultView: 'basicWeek',
      height: 500,
    eventClick: function(calEvent, jsEvent, view) {
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

    }
    });
  }
}