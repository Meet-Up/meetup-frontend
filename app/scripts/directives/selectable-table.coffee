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
              $elem.on 'mousedown touchstart', (e) ->
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
        button = e.which || e.button
        return if e.type == 'mousedown' && button != 1
        return if activated
        activated = true
        $scope.$emit 'moveStart', x, y
        false

      handleMove = (e, x, y) ->
        return if not activated
        $scope.$emit 'move', x, y
        false

      handleMoveEnd = (e, x, y) ->
        return if not activated
        activated = false
        $scope.$emit 'moveEnd', x, y
        false

