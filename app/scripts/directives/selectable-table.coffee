angular.module('meetupDirectives')
  .directive 'selectableTable', ($parse) ->
    restrict: 'A'
    link: ($scope, elem, attr) ->
      [childRow, childCell] = if elem.is 'table' then ['tr', 'td'] else ['.row', '.row']

      startRow = $parse(attr.startRow)() ? 0
      startColumn = $parse(attr.startColumn)() ? 0

      [startX, startY] = [-1, -1]
      isActivated = true
      isSelecting = false

      moveStart = (e, x, y) ->
        return if isActivated
        startX = x
        startY = y
        isActivated = true
        isSelecting = not $scope.isSelected(x, y)
