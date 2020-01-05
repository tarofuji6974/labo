import timeGridPlugin from '@fullcalendar/timegrid';
import '@fullcalendar/core/main.css';
import '@fullcalendar/timegrid/main.css';

$(document).on('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ timeGridPlugin ],
    defaultView: 'timeGrid',
    height: 500,
    nowIndicator: true
  });

  calendar.render();
});