angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, Event, TimeContainer, CalendarModel, $filter) ->

    $scope.event = new Event({ datesIndexes: {}, dates: [] })
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
      $scope.event.save()
