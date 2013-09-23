angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, Event, EventDate, DateHelper) ->

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
      if $scope.event.dates[key]
        delete $scope.event.dates[key]
      else
        eventDate = new EventDate()
        eventDate.start = date.clone().set { hours: 0, minute: 0 }
        eventDate.end = date.clone().set { hours: 23, minute: 59 }
        $scope.event.dates[key] = eventDate
