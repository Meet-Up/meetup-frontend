angular.module('meetupServices')
  .factory 'TimeContainer',  (DateHelper, TimeCell, CELLS_PER_DAY) ->

    getDateKey = (date) -> date.toString 'yyyyMMdd'

    class TimeContainer
      dates: []
      datesObj: {}
      changedCells: {}
      minRow: CELLS_PER_DAY - 1
      maxRow: 0

      constructor: (@isOpened) ->
        @isOpened ?= false
        if @isOpened
          @minRow = 0
          @maxRow = CELLS_PER_DAY - 1

      @fromEventDates: (eventDates) ->
        timeContainer = new TimeContainer()
        for eventDate in eventDates
          date = Date.parse(eventDate.date)
          times = (new TimeCell(n == '1') for n in eventDate.openTimes)
          timeContainer.dates.push { date: date, times: times}
        timeContainer

      updateDates: (dates) ->
        tmpDates = @datesObj
        @datesObj = {}
        @dates = []
        for date in dates
          key = getDateKey date
          if key of tmpDates
            @datesObj[key] = tmpDates[key]
          else
            @_initializeDate date
          @dates.push @datesObj[key]
        @dates.sort (a, b) -> a.date - b.date
        @setRows() unless @isOpened

      rows: -> [@minRow..@maxRow]

      getFirstRow: (start, end, step, condition) ->
        for i in [start..end] by step
          date = @dates[i]
          for time, j in date.times
            if time.isOpened() && condition(j)
              return j

      setMinRow: ->
        minRow = @getFirstRow 0, @dates.length - 1, 1, (j) => j < @minRow
        @minRow = minRow if minRow?

      setMaxRow: ->
        maxRow = @getFirstRow @dates.length - 1, 0, -1, (j) => j > @maxRow
        @maxRow = maxRow if maxRow?

      setRows: ->
        @setMinRow()
        @setMaxRow()

      getTimeCell: (x, y) -> @dates[x].times[y]

      _initializeDate: (date) ->
        key = getDateKey date
        return false if key of @datesObj
        @datesObj[key] =
          date: date
          times: (new TimeCell() for i in [0..CELLS_PER_DAY - 1])
        return true

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
