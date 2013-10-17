angular.module('meetupControllers')
  .controller 'EventInfoCtrl', ($scope, $state, Event) ->
    $scope.$watch 'calendar.selectedDates', ->
      dates = (date for k, date of $scope.calendar.selectedDates)
      $scope.timeContainer.updateDates dates
      $scope.$emit 'titleBar.update', { nextDisabled: !$scope.calendar.hasSelectedDates() }
    , true
