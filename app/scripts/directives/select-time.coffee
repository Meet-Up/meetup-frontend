angular.module('meetupDirectives')
  .directive 'selectTime', ($parse, $state, TimeContainer, TimeCell) ->
    getDates = ($scope, statusNumber) ->
      if statusNumber == TimeCell.AVAILABLE
        return $scope.event.dates if 'event' of $scope
      else if statusNumber == TimeCell.OPENED
        if 'calendar' of $scope
          dates = (date for k, date of $scope.calendar.selectedDates)
          return dates if dates.length > 0
        $state.go 'create-event.index'
      $state.go 'home'
      return

    restrict: 'E'
    replace: true
    transclude: false
    templateUrl: 'partials/create-event/select-time.html'

    controller: ($scope, $element, $attrs) ->
      statusNumber = TimeCell.getStatusFromName $attrs.selectionTarget
      dates = getDates $scope, statusNumber
      return unless dates?

      $scope.timeContainer = new TimeContainer(dates)

      [startX, startY] = [-1, -1]
      [lastX, lastY] = [-1, -1]

      $scope.$on 'moveStart', (e, x, y) ->
        [startX, startY] = [x, y]

      $scope.$on 'move', (e, x, y) ->
        return if x == lastX && y == lastY
        [lastX, lastY] = [x, y]

