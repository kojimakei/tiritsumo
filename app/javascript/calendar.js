// ※プラグイン※
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import timeGridPlugin from '@fullcalendar/timegrid';



  function initCalendar(){
    var calendarEl = document.getElementById('calendar');
  
    var calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: [ Calendar, dayGridPlugin, interactionPlugin, timeGridPlugin ],
      initialView: 'timeGridWeek',
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },

      // ※日本語表記に変更※
      locale: 'ja',
      height: 'auto',
      firstDay: 1,
      buttonText: {
      today: '今日',
      month: '月',
      list: 'リスト',     
      },       
      
      events: '/events.json',
    });
  
    calendar.render();
  }

  function addEvent(event){
    calendar.addEvent(event);
  }