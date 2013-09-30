angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, Event, calendarModel, $filter) ->

    $scope.event = new Event({ datesIndexes: {}, dates: [] })

    $scope.calendar = calendarModel

    $scope.hasSelectedDates = ->
      !$filter('isEmpty')($scope.calendar.selectedDates)

    $scope.$watch 'calendar.selectedDates', ->
      $scope.$emit 'titleBar.update', { nextDisabled: !$scope.hasSelectedDates() }
    , true

    $scope.saveEvent = ->
      $scope.event.save()
