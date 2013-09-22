angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, Event, EventDate) ->
    eventDate = new EventDate()
    eventDate.start = new Date()

    Event.query().then (results) ->
      console.log results
    , (error) ->
      console.log error

    $scope.event = new Event({
      name: 'foo'
      description: 'bar'
      dates: []
    })

    $scope.event.dates.push(eventDate)

    $scope.saveEvent = ->
      $scope.event.save()
