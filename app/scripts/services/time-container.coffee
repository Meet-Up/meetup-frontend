angular.module('meetupServices')
  .factory 'TimeContainer',  (EventDate, DateHelper, TimeCell, CELLS_PER_DAY) ->

    getDateKey = (date) -> date.toString 'yyyyMMdd'

    class TimeContainer
      dates: []
      datesObj: {}
      changedCells: {}
      minRow: CELLS_PER_DAY - 1
      maxRow: 0

      constructor: (@isOpened) ->
        @isOpened ?= false

      updateDates: (dates) ->
        tmpDates = @datesObj
        @datesObj = {}
        @dates = []
        for eventDate in dates
          [start, end] = @_getInterval eventDate
          dateKey = getDateKey start
          if dateKey of tmpDates
            @datesObj[dateKey] = tmpDates[dateKey]
          else
            @_initializeDate start
            @_initializeDateStatus start, end
          @dates.push @datesObj[dateKey]
        @dates.sort (a, b) -> a.date - b.date

      rows: -> if @dates.length > 0 then [@minRow..@maxRow] else []

      getTimeCell: (x, y) -> @dates[x].times[y]

      _getInterval: (eventDate) ->
        if eventDate instanceof EventDate
          [eventDate.start, eventDate.end]
        else
          start = eventDate.clone().set({ hour: 0, minute: 0})
          end = eventDate.clone().set({ hour: 23, minute: 59})
          [start, end]

      _initializeDate: (date) ->
        key = getDateKey date
        return false if key of @datesObj
        @datesObj[key] =
          date: date
          times: (new TimeCell(i) for i in [0..CELLS_PER_DAY - 1])
        return true

      _initializeDateStatus: (start, end) ->
        date = @datesObj[getDateKey start]
        startInfo = DateHelper.getDateIndexInfo start
        endInfo = DateHelper.getDateIndexInfo end
        endIndex = endInfo.index - (if endInfo.exact then 1 else 0)
        for i in [startInfo.index..endIndex]
          time = date.times[i]
          time.setOpened @isOpened

        @minRow = startInfo.index if startInfo.index < @minRow
        @maxRow = endIndex if endIndex > @maxRow

      _restoreStatus: (startX, endX, startY, endY, statusNumber) ->
        for k, status of @changedCells
          [x, y] = k.split ','
          continue if startX <= x <= endX and startY <= x <= endY
          @getTimeCell(x, y).updateStatus status, statusNumber

      _handleCellSelection: (startX, endX, startY, endY, isSelecting, statusNumber) ->
        if startX == endX && startY == endY
          cell = @getTimeCell(startX, startY)
          cell.updateStatus(!cell.getStatus(statusNumber), statusNumber)
        else
          for x in [startX..endX]
            for y in [startY..endY]
              cell = @getTimeCell(x, y)
              @changedCells[[x, y]] = cell.getStatus statusNumber unless [x, y] of @changedCells
              cell.updateStatus isSelecting, statusNumber
        return

      updateCells: (startPoint, endPoint, isSelecting, statusNumber) ->
        [startX, startY] = startPoint
        [endX, endY] = endPoint
        [startX, endX] = [endX, startX] if startX > endX
        [startY, endY] = [endY, startY] if startY > endY

        @_restoreStatus startX, endX, startY, endY, statusNumber
        @_handleCellSelection startX, endX, startY, endY, isSelecting, statusNumber

      comfirmCellsUpdate: ->
        @changedCells = {}
