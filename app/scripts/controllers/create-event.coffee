angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, $state, Event,
        eventContainer, TimeContainer, CalendarModel, createDialog, DEBUG) ->

    $scope.event = new Event()
    $scope.calendar = new CalendarModel()

    $scope.timeContainer = new TimeContainer(true)

    $scope.saveEvent = ->
      $scope.event.setDates $scope.timeContainer
      if DEBUG
        $state.go 'create-event.confirm'
      else
        $scope.event.save().then (evt) ->
          $state.go 'create-event.confirm'

    $scope.gotoEdit = ->
      eventContainer.addEvent $scope.event
      $state.go 'events', {
        token: $scope.event.token
      }

    $scope.$on 'createEvent', $scope.saveEvent

