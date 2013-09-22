angular.module('meetupServices')
  .factory 'DateHelper', ->
    getDaysForMonth = (date) ->
      start = date.clone().moveToFirstDayOfMonth().last().monday()
      end = date.moveToLastDayOfMonth().next().sunday()
      date = start
      days = []
      while date < end
        days.push date
        date = date.next().day().clone()

    getDaysForMonth: getDaysForMonth
