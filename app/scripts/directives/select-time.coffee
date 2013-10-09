angular.module('meetupDirectives')
  .directive 'selectTime', ($parse, $state, TimeContainer, TimeCell) ->
    getDates = ($scope, statusNumber) ->
      if statusNumber == TimeCell.AVAILABLE
        return $scope.event.dates if 'event' of $scope
      else if statusNumber == TimeCell.OPENED
        if 'calendar' of $scope
          dates = (date for k, date of $scope.calendar.selectedDates)
          return dates
      return []

    restrict: 'E'
    replace: true
    transclude: false
    templateUrl: 'partials/create-event/select-time.html'

    controller: ($scope, $element, $attrs) ->
      statusNumber = TimeCell.getStatusFromName $attrs.selectionTarget
      allowEmpty = $parse($attrs.allowEmpty)()

      dates = getDates $scope, statusNumber
      if dates.length == 0 && !allowEmpty
        $state.go if statusNumber == TimeCell.OPENED then 'create-event.index' else 'home'
        return

      $scope.timeContainer.updateDates dates

      getCell = (x, y) -> $scope.timeContainer.getTimeCell x, y

      [startX, startY] = [-1, -1]
      [lastX, lastY] = [-1, -1]

      isSelecting = false

      $scope.$on 'moveStart', (e, x, y) ->
        [startX, startY] = [x, y]
        isSelecting = !getCell(x, y).getStatus(statusNumber)
        onMove e, x, y

      onMove = (e, x, y) ->
        return if x == lastX && y == lastY
        [lastX, lastY] = [x, y]
        $scope.timeContainer.updateCells [startX, startY], [x, y], isSelecting, statusNumber
        $scope.$apply()

      $scope.$on 'move', onMove

      $scope.$on 'moveEnd', (e, x, y) ->
        $scope.timeContainer.comfirmCellsUpdate()
        [lastX, lastY] = [-1, -1]
