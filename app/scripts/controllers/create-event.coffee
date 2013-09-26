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
      date = date.clone().set { hour: 0, minute: 0 }
      if $scope.event.hasDate date
        delete $scope.event.removeDate date
      else
        end = date.clone().set { hour: 23, minute: 59}
        $scope.event.addDate date, end
