angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, Event, EventDate, DateHelper) ->

    $scope.event = new Event({ datesIndexes: {}, dates: [] })
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
      if key of $scope.event.datesIndexes
        index = $scope.event.datesIndexes[key]
        delete $scope.event.dates[index]
      else
        eventDate = new EventDate()
        eventDate.start = date.clone().set { hour: 0, minute: 0 }
        eventDate.end = date.clone().set { hour: 23, minute: 59 }
        $scope.event.dates[key] = eventDate
