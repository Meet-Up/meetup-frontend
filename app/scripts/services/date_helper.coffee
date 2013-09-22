angular.module('meetupServices')
  .factory 'DateHelper', ->
    getDaysForMonth = (date) ->
      start = date.clone().moveToFirstDayOfMonth()
      start = start.last().monday() unless start.is().monday()
      end = date.moveToLastDayOfMonth()
      end = end.next().sunday() unless end.is().sunday()
      days = []
      while start <= end
        days.push start
        start = start.clone().next().day()
      days

    getDaysForMonth: getDaysForMonth
