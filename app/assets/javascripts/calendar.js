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
function updateCalendar(newDates) {
  var dates = newDates.responseJSON;
  var weekStart = new Date(dates[0]);
  var weekEnd = new Date(dates[4]);
  var year = weekEnd.getUTCFullYear();
  
  $('.week-scroll').text( months[weekStart.getMonth()] + " " + weekStart.getUTCDate() + ' - ' + weekEnd.getUTCDate() );
  
  $('.week-scroll').append(" <span>" + weekEnd.getUTCFullYear() + "</span>")

}
$( document ).ready(function() {
  var week = 0;
  $('div.next-week').click(function() {
    week += 1;
    getDates(week)
  })

  $('div.prev-week').click(function() {
    week -= 1;
    getDates(week)
  })

  function getDates(week) {
    var newDates = $.get( "/appointments/new_week", { week: week }).done(function() {
      dates = newDates
      updateCalendar(newDates);
    }) 
  }


}) //end doc ready
