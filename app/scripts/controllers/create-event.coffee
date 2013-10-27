angular.module('MeetAppControllers')
  .controller 'CreateEventCtrl', ($scope, $state, Event,
        eventContainer, TimeContainer, CalendarModel, DEVICE, DEBUG) ->

    $scope.event = new Event()
    $scope.calendar = new CalendarModel()

    $scope.timeContainer = new TimeContainer(true)

    if DEVICE == 'desktop'
      $scope.$watch 'calendar.selectedDates', ->
        dates = (date for k, date of $scope.calendar.selectedDates)
        $scope.timeContainer.updateDates dates
      , true
      $scope.timeContainer.onValidTimesChange = ->
        unless $scope.$$phase
          $scope.$apply()

    $scope.saveEvent = ->
      $scope.event.dates = $scope.timeContainer.toEventDates()
      if DEBUG
        $state.go 'create-event.confirm'
      else
        $scope.event.save().then (evt) ->
          $scope.event.currentPassword = $scope.event.password
          $scope.timeContainer.setDates $scope.event.dates
          $state.go 'create-event.confirm'
          eventContainer.addEvent $scope.event

    $scope.gotoInput = ->
      $state.go 'events', {
        token: $scope.event.token
      }

    $scope.$on 'createEvent', $scope.saveEvent
