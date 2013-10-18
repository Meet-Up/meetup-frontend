angular.module('MeetAppFilters')
  .filter 'timeFromIndex', (CELLS_PER_DAY) ->
    (input) ->
      minutesPerCell = 24 * 60 / CELLS_PER_DAY
      date = Date.today().addMinutes minutesPerCell * input
      date.toString 'HH:mm'
