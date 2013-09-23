angular.module('meetupServices')
  .factory 'DateHelper', (CELLS_PER_DAY)->


    getDaysForMonth: (date) ->
      start = date.clone().moveToFirstDayOfMonth()
      start = start.last().monday() unless start.is().monday()
      end = date.clone().moveToLastDayOfMonth()
      end = end.next().sunday() unless end.is().sunday()
      days = []
      while start <= end
        days.push start
        start = start.clone().next().day()
      days

    getWeeksInMonth: (date) ->
      days = @getDaysForMonth(date)
      (days[n..n+6] for n in [0..days.length-1] by 7)


    getCellsNumberInDay: (start, end) ->
      minutesDiff = (end - start) / 60000
      minutesPerCell = 24 * 60 / CELLS_PER_DAY
      Math.floor(minutesDiff / minutesPerCell)
