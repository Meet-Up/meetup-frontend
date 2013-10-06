angular.module('meetupDirectives')
  .directive 'selectableTable', ($parse) ->
    restrict: 'A'
    terminal: true

    link: ($scope, elem, attr) ->
      [childRow, childCell] = if elem.is 'table' then ['tr', 'td'] else ['.row', '.cell']

      startRow = $parse(attr.startRow)() ? 0
      startColumn = $parse(attr.startColumn)() ? 0

      [startX, startY] = [-1, -1]
      activated = false

      $scope.$on 'ngRepeatFinished', ->
        console.log(elem.find(childRow).length)

      elem.find(childRow).slice(startRow).each (y) ->
        $(this).find(childCell).slice(startColumn).each (x) ->
          $(this).on 'mousedown touchstart', (e) ->
            handleMoveStart e, x, y
          $(this).on 'mousemove', (e) ->
            handleMove e, x, y
          $(this).on 'mouseup touchend', (e) ->
            handleMoveEnd e, x, y


      handleMoveStart = (e, x, y) ->
        return if activated
        startX = x
        startY = y
        activated = true
        false

      handleMove = (e, x, y) ->
        return if not activated
        console.log (x + " " + y)
        false

      handleMoveEnd = (e, x, y) ->
        return if not activated
        activated = false
        false

