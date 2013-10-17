angular.module('meetupDirectives')
  .directive 'selectTime', ($parse, $state, $filter, TimeContainer, TimeStatus, DEVICE, DAYS_PER_PAGE) ->

    [startX, startY] = [-1, -1]
    [lastX, lastY] = [-1, -1]
    isSelecting = false
    statusNumber = 0

    cells = []

    onMove = (e, x, y, $scope) ->
      return if x == lastX && y == lastY
      [lastX, lastY] = [x, y]
      toUpdate = $scope.timeContainer.updateCells [startX, startY], [x, y], isSelecting, statusNumber
      for cell in toUpdate
        if cell.selected
          cells.eq(cell.y * DAYS_PER_PAGE + cell.x).addClass 'selected-true'
          cells.eq(cell.y * DAYS_PER_PAGE + cell.x).removeClass 'selected-false'
        else
          cells.eq(cell.y * DAYS_PER_PAGE + cell.x).addClass 'selected-false'
          cells.eq(cell.y * DAYS_PER_PAGE + cell.x).removeClass 'selected-true'

    initializeEvents = ($scope, statusNumber) ->
      getCell = (x, y) -> $scope.timeContainer.getTimeCell x, y

      $scope.$on 'moveStart', (e, x, y) ->
        x += ($scope.page - 1) * DAYS_PER_PAGE
        y += $scope.timeContainer.minRow
        [startX, startY] = [x, y]
        isSelecting = !getCell(x, y).getStatus(statusNumber)
        onMove e, x, y, $scope

      $scope.$on 'move', (e, x, y) ->
        x += ($scope.page - 1) * DAYS_PER_PAGE
        y += $scope.timeContainer.minRow
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

    link: ($scope, element, attr) ->
      $scope.$on 'ngRepeatFinished', ->
        cells = element.find('.time-cell')

    controller: ($scope, $element, $attrs) ->
      $scope.daysPerPage = DAYS_PER_PAGE
      $scope.daysIndexes = [0..DAYS_PER_PAGE - 1]
      $scope.page = 1
      $scope.dates = []
      $scope.rows = $scope.timeContainer.rows()

      statusNumber = TimeStatus.getStatusFromName $attrs.selectionTarget
      allowEmpty = $parse($attrs.allowEmpty)()

      $scope.cssClass = $attrs.selectionTarget

      $scope.maxPage = -> Math.ceil($scope.datesNumber / DAYS_PER_PAGE)

      $scope.isOpened = (x, y) ->
        x += ($scope.page - 1) * DAYS_PER_PAGE
        return false if x >= $scope.timeContainer.dates.length
        $scope.timeContainer.getTimeCell(x, y).isOpened()

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

      $scope.selectAll = (dateInfo) ->
        isOpened = dateInfo.times[0].isOpened()
        for time in dateInfo.times
          time.setOpened !isOpened


      initializeEvents $scope, statusNumber

      updateScopeData $scope

      $scope.$watch 'timeContainer', () ->
        updateScopeData $scope
      , true
