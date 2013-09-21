angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, Event, EventDate) ->
    eventDate = new EventDate()
    eventDate.start = new Date()

    $scope.event = new Event({
      name: 'foo'
      description: 'bar'
      dates: []
    })

    $scope.event.dates.push(eventDate)

    $scope.saveEvent = ->
      $scope.event.save()
