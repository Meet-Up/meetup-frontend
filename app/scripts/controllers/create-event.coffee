angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, Event, EventDate, DateHelper, $state) ->

    $scope.event = new Event({ dates: {} })
    $scope.daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S']

    setDate = (date) ->
      $scope.calendar = {
        date: date
        weeks: DateHelper.getWeeksInMonth date
      }

    setDate Date.today()

    $scope.saveEvent = ->
      $scope.event.save()

    $scope.toLastMonth = ->
      newDate = $scope.calendar.date.last().month()
      setDate newDate

    $scope.toNextMonth = ->
      newDate = $scope.calendar.date.next().month()
      setDate newDate

    $scope.toggleDate = (date) ->
      key = date.toString 'yyMMdd'
      oldStatus = $scope.event.dates[key] ? false
      $scope.event.dates[key] = not oldStatus


