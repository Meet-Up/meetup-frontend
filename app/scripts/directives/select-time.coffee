angular.module('meetupDirectives')
  .directive 'selectTime', ($parse, $state, $filter, TimeContainer, TimeCell, DEVICE) ->
    DAYS_PER_PAGE = 5

    [startX, startY] = [-1, -1]
    [lastX, lastY] = [-1, -1]
    isSelecting = false
    statusNumber = 0

    getDates = ($scope, statusNumber) ->
      if statusNumber == TimeCell.AVAILABLE
        return $scope.event.dates if 'event' of $scope
      else if statusNumber == TimeCell.OPENED
        if 'calendar' of $scope
          dates = (date for k, date of $scope.calendar.selectedDates)
          return dates
      return []

    onMove = (e, x, y, $scope) ->
      return if x == lastX && y == lastY
      [lastX, lastY] = [x, y]
      $scope.timeContainer.updateCells [startX, startY], [x, y], isSelecting, statusNumber
      $scope.$apply()

    initializeEvents = ($scope, statusNumber) ->
      getCell = (x, y) -> $scope.timeContainer.getTimeCell x, y

      $scope.$on 'moveStart', (e, x, y) ->
        [startX, startY] = [x, y]
        isSelecting = !getCell(x, y).getStatus(statusNumber)
        onMove e, x, y, $scope

      $scope.$on 'move', (e, x, y) ->
        onMove e, x, y, $scope

      $scope.$on 'moveEnd', (e, x, y) ->
        $scope.timeContainer.comfirmCellsUpdate()
        [lastX, lastY] = [-1, -1]

    updateScopeData = ($scope) ->
      $scope.rows = $scope.timeContainer.rows()
      $scope.dates = $filter('paginate')($scope.timeContainer.dates, $scope.page, DAYS_PER_PAGE)
      $scope.datesNumber = $scope.timeContainer.dates.length

    restrict: 'E'
    replace: true
    transclude: false
    templateUrl: "partials/#{DEVICE}/create-event/select-time.html"

    controller: ($scope, $element, $attrs) ->
      $scope.daysPerPage = DAYS_PER_PAGE
      $scope.page = 1
      $scope.dates = []

      statusNumber = TimeCell.getStatusFromName $attrs.selectionTarget
      allowEmpty = $parse($attrs.allowEmpty)()

      dates = getDates $scope, statusNumber
      if dates.length == 0 && !allowEmpty
        $state.go if statusNumber == TimeCell.OPENED then 'create-event.index' else 'home'
        return

      $scope.maxPage = -> Math.ceil($scope.datesNumber / DAYS_PER_PAGE)

      $scope.previousPage = ->
        $scope.page -= 1
        updateScopeData($scope)
      $scope.nextPage = ->
        $scope.page += 1
        updateScopeData($scope)

      $scope.timeContainer.updateDates dates

      initializeEvents $scope, statusNumber

      updateScopeData $scope

      $scope.$watch 'timeContainer', () ->
        updateScopeData $scope
      , true
