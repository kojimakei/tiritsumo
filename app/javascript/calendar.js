import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import timeGridPlugin from '@fullcalendar/timegrid';

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, interactionPlugin, timeGridPlugin ],
    initialView: 'timeGridWeek',
    events: [
      {
          id: '1',
          title: '筋トレ',
          start: '2021-01-24T10:00:00',
          end: '2021-01-24T12:00:00',
          url: '#'
      },
      {
          id: '2',
          title: '先輩とご飯',
          start: '2021-01-23T10:00:00',
          url: '#'
      },
      {
          id: '3',
          title: 'ポートフォリオ作成',
          start: '2021-01-18T15:00:00',
          end: '2021-01-18T19:00:00', 
          url: '#'
      }
  ],

    // ※日本語表記に変更※
    locale: 'ja',
    height: 'auto',
    firstDay: 1,
    buttonText: {
      today: '今日',
      month: '月',
      list: 'リスト',     
    }, 

  });

  calendar.render();

});
