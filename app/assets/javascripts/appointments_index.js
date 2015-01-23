var AppointmentsIndex = {
	setButtons: function(){
		$(".show-family-button").on("click", function(e){
			e.preventDefault();
			var appt_id = $(this).closest(".appt-id").data("appt-id");
			$.ajax({
				type: "GET",
				datatype: "script",
				data: {},
				url: "/appointments/"+appt_id,
				success: function(response){
				} 
			})
		})
	}
}

var AppointmentsCalender = {
	review: function(){
    $('#appointments-cal').replaceWith("<div id='appointments-cal'></div>");
    $('#appointments-cal').fullCalendar({
      header: {
          left: '',
          center: '',
          right: 'today prev,next'
      },
      timezone: "local",
      // events: '/availabilities.json',
      eventSources: [
        {
          url: '/appointments.json',
          type: "GET",
          async:false,
          data: {
            dietitian_id: "All"
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
        $(element).attr("data-toggle", "tooltip").attr("data-placement", "top").attr("title", event.description).tooltip();
      }
    });
  }
}
