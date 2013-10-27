angular.module('MeetAppDirectives')
  .directive 'selectTime', ($parse, $state, $filter, TimeContainer, TimeStatus, DEVICE, DAYS_PER_PAGE) ->

    [startX, startY] = [-1, -1]
    [lastX, lastY] = [-1, -1]
    isSelecting = false
    statusNumber = 0

    cells = []
    errorElement = {}

    onMove = (e, x, y, $scope) ->
      return if x == lastX && y == lastY
      [lastX, lastY] = [x, y]
      toUpdate = $scope.container.updateCells [startX, startY], [x, y], isSelecting, statusNumber
      for cell in toUpdate
        index = (cell.y - $scope.container.minRow) * DAYS_PER_PAGE + cell.x
        if cell.selected
          cells.eq(index).addClass 'selected'
        else
          cells.eq(index).removeClass 'selected'

    initializeEvents = ($scope, statusNumber) ->
      getCell = (x, y) -> $scope.container.getTimeCell x, y

      $scope.$on 'moveStart', (e, x, y) ->
        x += ($scope.page - 1) * DAYS_PER_PAGE
        y += $scope.container.minRow
        [startX, startY] = [x, y]
        isSelecting = !getCell(x, y).getStatus(statusNumber)
        onMove e, x, y, $scope

      $scope.$on 'move', (e, x, y) ->
        x += ($scope.page - 1) * DAYS_PER_PAGE
        y += $scope.container.minRow
        onMove e, x, y, $scope

      $scope.$on 'moveEnd', (e, x, y) ->
        $scope.container.comfirmCellsUpdate()
        errorElement.toggle(!$scope.container.hasValidTimes)
        [lastX, lastY] = [-1, -1]

    updateScopeData = ($scope) ->
      $scope.dates = $filter('paginate')($scope.container.dates, $scope.page, DAYS_PER_PAGE)
      $scope.datesNumber = $scope.container.dates.length
      $scope.container.updateValidity()

    restrict: 'EA'
    replace: false
    transclude: false
    terminal: true
    templateUrl: "partials/#{DEVICE}/select-time/main.html"

    link: ($scope, element, attr) ->
      errorElement = element.find '.error'
      $scope.$on 'ngRepeatFinished', ->
        cells = element.find('.time-cell')
        $scope.$broadcast 'initScrollPane'

    controller: ($scope, $element, $attrs) ->
      $scope.daysPerPage = DAYS_PER_PAGE
      $scope.daysIndexes = [0..DAYS_PER_PAGE - 1]
      $scope.page = 1
      $scope.dates = []
      containerName = if 'containerName' of $attrs then $attrs.containerName else 'timeContainer'
      $scope.container = $scope[containerName]

      $scope.rows = $scope.container.rows()

      statusNumber = TimeStatus.getStatusFromName $attrs.selectionTarget
      allowEmpty = $parse($attrs.allowEmpty)()

      $scope.cssClass = $attrs.selectionTarget
      $scope.selectable = $parse($attrs.selectable)() ? false
      $scope.scrollable = $parse($attrs.scrollable)() ? false
      $scope.heatMap = $parse($attrs.heatMap)() ? $element.hasClass 'heat-map'

      if $scope.heatMap
        $scope.cssClass += " heat-map"
        $scope.getOpacity = (x, y) ->
          return 1 unless $scope.isOpened(x, y)
          rate = $scope.availabilityContainer.availabilityRate(x, y)
          alpha = Math.round(rate * 100)
          # strange bug with firefox when alpha=1 or alpha=0
          alpha = 1 if  alpha == 0
          alpha = 99 if  alpha == 100
          alpha
      else
        $scope.getOpacity = -> 1

      $scope.maxPage = -> Math.ceil($scope.datesNumber / DAYS_PER_PAGE)

      $scope.isOpened = (x, y) ->
        return true if $scope.container.isOpened
        x += ($scope.page - 1) * DAYS_PER_PAGE
        return false if x >= $scope.container.dates.length
        $scope.container.getTimeCell(x, y).isOpened()

      $scope.isSelected = (x, y) ->
        return false unless $scope.selectable
        x += ($scope.page - 1) * DAYS_PER_PAGE
        return false if x >= $scope.container.dates.length
        $scope.container.getTimeCell(x, y).getStatus statusNumber

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

      if $scope.selectable
        initializeEvents $scope, statusNumber

      updateScopeData $scope

      $scope.$watch containerName, () ->
        updateScopeData $scope
      , true
