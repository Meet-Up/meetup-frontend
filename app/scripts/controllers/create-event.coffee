angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, $filter, $state, Event,
        eventContainer, TimeContainer, CalendarModel, createDialog, DEBUG) ->

    $scope.event = new Event({ datesIndexes: {}})
    $scope.calendar = new CalendarModel()

    $scope.timeContainer = new TimeContainer(true)

    $scope.hasSelectedDates = ->
      !$filter('isEmpty')($scope.calendar.selectedDates)

    $scope.$watch 'calendar.selectedDates', ->
      dates = (date for k, date of $scope.calendar.selectedDates)
      $scope.timeContainer.updateDates dates
      $scope.$emit 'titleBar.update', { nextDisabled: !$scope.hasSelectedDates() }
    , true

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

