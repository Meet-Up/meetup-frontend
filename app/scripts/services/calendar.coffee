angular.module('meetupServices')
  .factory 'CalendarModel', (DateHelper) ->
    class CalendarModel
      constructor: () ->
        @selectedDates = {}
        @setDate Date.today()
        @toggable = false
        @noToolbar = false

      setDate: (date) ->
        @date = date
        @weeks = DateHelper.getWeeksInMonth date

      toLastMonth: ->
        @setDate @date.last().month()

      toNextMonth: ->
        @setDate @date.next().month()
