

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


var ChooseApptCalendar = {
    // new user sign in form validations
    set: function(){
    $('#choose-appt-cal').fullCalendar({
      timezone: "local",
      events: '/time_slots.json',
      defaultView: 'basicWeek',
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
}