angular.module('meetupServices')
  .factory 'calendarModel', (DateHelper) ->
    class CalendarModel
      date: Date.today()
      selectedDates: {}
      toggable: false
      noToolbar: false

      daysOfWeek: ['M', 'T', 'W', 'T', 'F', 'S', 'S']

      constructor: () ->
        @setDate Date.today()

      setDate: (date) ->
        @date = date
        @weeks = DateHelper.getWeeksInMonth date

      toLastMonth: ->
        @setDate @date.last().month()

      toNextMonth: ->
        @setDate @date.next().month()


    new CalendarModel()
