angular.module('meetupDirectives')
  .directive 'selectableTable', ($parse) ->
    restrict: 'A'

    link: ($scope, element, attr) ->
      isTable = element.is 'table'
      [childRow, childCell] = if isTable then ['tr', 'td'] else ['.row', '.cell']

      elem = if isTable then element.find 'tbody' else element
      headerSelector = if isTable then 'theader' else 'header'
      header = elem.children headerSelector

      startRow = $parse(attr.startRow)() ? 0
      startColumn = $parse(attr.startColumn)() ? 0
      [startX, startY] = [-1, -1]
      [startTouchX, startTouchY] = [-1, -1]
      [cellWidth, cellHeight] = [-1, -1]

      activated = false

      rows = {}

      initialize = ->
        elem.off()
        header.off()
        rows = elem.find(childRow)
        rows.each (j) ->
          $(this).find(childCell).each (i) ->
            $elem = $(this)
            $elem.off()
            if i < startColumn || j < startRow
              $elem.on 'mouseenter', handleMoveEnd
            else
              [x, y] = [i - startColumn, j - startRow]
              $elem.on 'touchstart', (e) ->
                handleTouchStart e
                handleMoveStart e, x, y
              $elem.on 'mousedown', (e) ->
                handleMoveStart e, x, y
              $elem.on 'mousemove', (e) ->
                handleMove e, x, y
              $elem.on 'touchmove', handleTouchMove
              $elem.on 'mouseup touchend', (e) ->
                handleMoveEnd e, x, y

        rows = rows.slice(startRow)

        elem.on 'mouseleave', handleMoveEnd
        header.on 'mouseenter', handleMoveEnd

      initialize()
      $scope.$on 'ngRepeatFinished', ->
        initialize()
        cellWidth = $('.cell').width()
        cellHeight = $('.cell').height()

      handleTouchStart = (e) ->
        startTouchX = e.originalEvent.changedTouches[0].pageX
        startTouchY = e.originalEvent.changedTouches[0].pageY

      lastEvent = new Date()

      handleTouchMove = (e) ->
        e.preventDefault()
        return if new Date() - lastEvent < 50
        lastEvent = new Date()
        return if not activated
        cellCols = Math.floor((e.originalEvent.changedTouches[0].pageX - startTouchX + cellWidth / 2) / cellWidth)
        cellRows = Math.floor((e.originalEvent.changedTouches[0].pageY - startTouchY + cellHeight / 2) / cellHeight)
        handleMove e, cellCols + startX, cellRows + startY

      handleMoveStart = (e, x, y) ->
        e.preventDefault()
        [startX, startY] = [x, y]
        button = e.which || e.button
        return if e.type == 'mousedown' && button != 1
        return if activated
        activated = true
        $scope.$emit 'moveStart', x, y

      handleMove = (e, x, y) ->
        return if not activated
        $scope.$emit 'move', x, y

      handleMoveEnd = (e, x, y) ->
        return if not activated
        activated = false
        $scope.$emit 'moveEnd', x, y

