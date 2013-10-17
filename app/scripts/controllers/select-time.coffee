angular.module('meetupControllers')
  .controller 'SelectTimeCtrl', ($scope, $state, $filter) ->
    hasDates = $scope.calendar? && !$filter('isEmpty')($scope.calendar.selectedDates)
    unless hasDates && $scope.timeContainer?
      $state.go '^.index'
      return

    $scope.timeContainer.onValidTimesChange = ->
      $scope.$emit 'titleBar.update', { nextDisabled: !$scope.timeContainer.hasValidTimes }
      $scope.$apply()

