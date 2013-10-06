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

      rows = {}

      $scope.$on 'ngRepeatFinished', ->
        rows = elem.find(childRow).slice(startRow)
        rows.each (y) ->
          $(this).find(childCell).slice(startColumn).each (x) ->
            $(this).on 'mousedown touchstart', (e) ->
              handleMoveStart e, x, y
            $(this).on 'mousemove', (e) ->
              handleMove e, x, y
            $(this).on 'touchmove', handleTouchMove
            $(this).on 'mouseup touchend', (e) ->
              handleMoveEnd e, x, y

      lastEvent = new Date()

      handleTouchMove = (e) ->
        return if not activated
        return false if new Date() - lastEvent < 150
        lastEvent = new Date()
        changedTouches = e.originalEvent.changedTouches
        [xPos, yPos] = [changedTouches[0].pageX, changedTouches[0].pageY]
        nearestCell = $.nearest({x: xPos, y: yPos}, childCell)
        [x, y] = [nearestCell.index() - startColumn, rows.index nearestCell.parent('tr')]
        handleMove e, x, y

      handleMoveStart = (e, x, y) ->
        return if activated
        startX = x
        startY = y
        activated = true
        console.log "START"
        false

      handleMove = (e, x, y) ->
        return if not activated
        false

      handleMoveEnd = (e, x, y) ->
        return if not activated
        activated = false
        console.log "END"
        false

