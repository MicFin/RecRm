
Kindrdfood = Kindrdfood || {};

Kindrdfood.dietitians = Kindrdfood.dietitians || {};

Kindrdfood.dietitians.show = {

  init: function(){
    var dietitian_id = window.location.href.substring(window.location.href.lastIndexOf('/') + 1);
    $('#availability-cal').fullCalendar({
      header: {
          left: '',
          center: '',
          right: 'today prev,next'
      },
      timezone: "local",
      eventSources: [
        {
          url: '/availabilities.json',
          type: "GET",
          async: false,
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
          async: false,
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
      minTime: "05:00:00",
      maxTime: "24:00:00",
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
}