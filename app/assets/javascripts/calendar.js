var months = {
  0: "January",
  1: "February",
  2: "March",
  3: "April",
  4: "May",
  5: "June",
  6: "July",
  7: "August",
  8: "Septemer",
  9: "October",
  10: "November",
  11: "December"
}

var weekdays = {
  0: "Sun",
  1: "Mon",
  2: "Tue",
  3: "Wed",
  4: "Thu",
  5: "Fri"
}
function getDates(week) {
  var newDates = $.get( "/appointments/new_week", { week: week }).done(function() {
    dates = newDates
    updateCalendar(newDates);
  }) 
}
function updateCalendar(newDates) {
  dates = newDates.responseJSON;
  var weekStart = new Date(dates[0].day);
  var weekEnd = new Date(dates[4].day);
  var year = weekEnd.getUTCFullYear();
  
  $('.week-scroll-display').text( months[weekStart.getMonth()] + " " + weekStart.getUTCDate() + ' - ' + weekEnd.getUTCDate() );
  
  $('span#year').empty().text(weekEnd.getUTCFullYear() );
  $('.dates').empty();
  for(var i = 0; i < dates.length; i++) {
      var day = new Date(dates[i].day)
      $('.dates')
        .append("<div class='day' id="+i+">" + "<div class='day-label'>"+ weekdays[day.getUTCDay()] + " " + parseInt(day.getUTCMonth() + 1) +"/"+day.getUTCDate()+ "</div></div>")
      $("div.day#"+i).addClass("color-" + i % 2)
  }

}
$( document ).ready(function() {
  var week = 0;
  
  $('div.js-next-week').click(function() {
    week += 1;
    getDates(week);
  })

  $('div.js-prev-week').click(function() {
    week -= 1;
    getDates(week)
  })
}) //end doc ready
