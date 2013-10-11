angular.module('meetupDirectives')
  .directive 'selectTime', ($parse, $state, $filter, TimeContainer, TimeCell, DEVICE, DAYS_PER_PAGE) ->

    [startX, startY] = [-1, -1]
    [lastX, lastY] = [-1, -1]
    isSelecting = false
    statusNumber = 0

    onMove = (e, x, y, $scope) ->
      return if x == lastX && y == lastY
      [lastX, lastY] = [x, y]
      $scope.timeContainer.updateCells [startX, startY], [x, y], isSelecting, statusNumber
      $scope.$apply()

    initializeEvents = ($scope, statusNumber) ->
      getCell = (x, y) -> $scope.timeContainer.getTimeCell x, y

      $scope.$on 'moveStart', (e, x, y) ->
        x += ($scope.page - 1) * DAYS_PER_PAGE
        [startX, startY] = [x, y]
        isSelecting = !getCell(x, y).getStatus(statusNumber)
        onMove e, x, y, $scope

      $scope.$on 'move', (e, x, y) ->
        x += ($scope.page - 1) * DAYS_PER_PAGE
        onMove e, x, y, $scope

      $scope.$on 'moveEnd', (e, x, y) ->
        $scope.timeContainer.comfirmCellsUpdate()
        [lastX, lastY] = [-1, -1]

    updateScopeData = ($scope) ->
      $scope.dates = $filter('paginate')($scope.timeContainer.dates, $scope.page, DAYS_PER_PAGE)
      $scope.datesNumber = $scope.timeContainer.dates.length

    restrict: 'E'
    replace: true
    transclude: false
    terminal: true
    templateUrl: "partials/#{DEVICE}/select-time/main.html"

    controller: ($scope, $element, $attrs) ->
      $scope.daysPerPage = DAYS_PER_PAGE
      $scope.daysIndexes = [0..DAYS_PER_PAGE - 1]
      $scope.page = 1
      $scope.dates = []
      $scope.rows = $scope.timeContainer.rows()

      statusNumber = TimeCell.getStatusFromName $attrs.selectionTarget
      allowEmpty = $parse($attrs.allowEmpty)()

      $scope.maxPage = -> Math.ceil($scope.datesNumber / DAYS_PER_PAGE)

      $scope.isSelected = (x, y) ->
        x += ($scope.page - 1) * DAYS_PER_PAGE
        return false if x >= $scope.timeContainer.dates.length
        $scope.timeContainer.getTimeCell(x, y).getStatus statusNumber

      $scope.previousPage = ->
        $scope.page -= 1
        updateScopeData($scope)
      $scope.nextPage = ->
        $scope.page += 1
        updateScopeData($scope)

      initializeEvents $scope, statusNumber

      updateScopeData $scope

      $scope.$watch 'timeContainer', () ->
        updateScopeData $scope
      , true
