

var updateEvent;

$(document).ready(function() {
  var todayDate = new Date();
  todayDate.setHours(0,0,0,0);

  $('#calendar').fullCalendar({
    editable: false,
    slotEventOverlap: false,
    monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
    monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
    dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
    dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'],
    columnFormat: {
      month: 'dddd',
      week: 'dddd d',
      day: 'ddd'
    },
    buttonText: {
      today: 'Hoy',
      month: 'month',
      week: 'week',
      day: 'day'
    },
    minTime: "08:00:00",
    maxTime: "23:00:00",
    header: {
      left: 'prev,next today',
      center: 'title',
      right: ''
    },
    firstDay: 1,
    //this section is triggered when the event cell it's clicked
    selectable: true,
    selectHelper: true,
    select: function(start, end) {
      var user_name;
      user_name = prompt("User name: ");
      var eventData;
      //this validates that the user must insert a name in the input
      if (user_name) {
        eventData = {
          title: "Reserved",
          start: start,
          end: end,
          user_name: user_name
        };
        //here i validate that the user can't create an event before today
        if (eventData.start < todayDate){
          alert('You can't choose a date that already past.');
          $("#calendar").fullCalendar("unselect");
          return
        }
        //if everything it's ok, then the event is saved in database with ajax
        $.ajax({
          url: "events",
          type: "POST",
          data: eventData,
          dataType: 'json',
          success: function(json) {
            alert(json.msg);
            $("#calendar").fullCalendar("renderEvent", eventData, true);
            $("#calendar").fullCalendar("refetchEvents");
          }
        });
      }
      $("#calendar").fullCalendar("unselect");
    },  
    defaultView: 'agendaWeek',
    allDaySlot: false,
    height: 500,
    slotMinutes: 30,
    eventSources: [
      {
        url: '/events'
      }
    ],
    timeFormat: 'h:mm t{ - h:mm t} ',
    dragOpacity: "0.5"
  });
};