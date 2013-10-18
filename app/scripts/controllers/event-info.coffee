angular.module('MeetAppControllers')
  .controller 'EventInfoCtrl', ($scope, $state, Event) ->
    $scope.$watch 'calendar.selectedDates', ->
      $scope.$emit 'titleBar.update', { nextDisabled: !$scope.calendar.hasSelectedDates() }
    , true
