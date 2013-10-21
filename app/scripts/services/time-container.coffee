angular.module('MeetAppServices')
  .factory 'TimeContainer',  (DateHelper, TimeCell, TimeStatus, CELLS_PER_DAY) ->

    getDateKey = (date) -> date.toString 'yyyyMMdd'

    class TimeContainer

      constructor: (@isOpened) ->
        @dates = []
        @datesObj = {}
        @changedCells = {}
        @minRow = CELLS_PER_DAY - 1
        @maxRow = 0
        @hasValidTimes = false
        @isOpened ?= false
        if @isOpened
          @minRow = 0
          @maxRow = CELLS_PER_DAY - 1

      @fromEventDates: (eventDates, nestedId) ->
        timeContainer = new TimeContainer()
        timeContainer.setDates eventDates
        timeContainer

      setDates: (eventDates) ->
        @dates = []
        for eventDate in eventDates
          date = Date.parse(eventDate.date)
          times = (new TimeCell(n == '1') for n in eventDate.times)
          @dates.push { date: date, times: times, id: eventDate.id, eventDateId: eventDate.eventDateId }
        @_fixDates()

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
        @_fixDates()

      _fixDates: ->
        @dates.sort (a, b) -> a.date - b.date
        @setRows() unless @isOpened

      rows: -> [@minRow..@maxRow]

      setFirstRow: (start, end, step, condition, save) ->
        for i in [start..end] by step
          date = @dates[i]
          for time, j in date.times
            if time.isOpened() && condition(j)
              save(j)
        return

      setMinRow: ->
        @setFirstRow 0, @dates.length - 1, 1, ((j) => j < @minRow), ((j) => @minRow = j)

      setMaxRow: ->
        @setFirstRow @dates.length - 1, 0, -1, ((j) => j > @maxRow), ((j) => @maxRow = j)

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
        toUpdate = []
        if startX == endX && startY == endY
          cell = @getTimeCell(startX, startY)
          if cell.canUpdateStatus(statusNumber)
            cell.updateStatus(!cell.getStatus(statusNumber), statusNumber)
            toUpdate.push({x: startX, y: startY, selected: cell.getStatus statusNumber})
        else
          for x in [startX..endX]
            for y in [startY..endY]
              cell = @getTimeCell(x, y)
              continue unless cell.canUpdateStatus(statusNumber)
              @changedCells[[x, y]] = cell.getStatus statusNumber unless [x, y] of @changedCells
              cell.updateStatus isSelecting, statusNumber
              toUpdate.push({x: x, y: y, selected: cell.getStatus(statusNumber)})

          for k, status of @changedCells
            [x, y] = k.split ','
            if x < startX || x > endX || y < startY || y > endY
              toUpdate.push({x: parseInt(x, 10), y: parseInt(y, 10), selected: status})
        toUpdate

      updateCells: (startPoint, endPoint, isSelecting, statusNumber) ->
        [startX, startY] = startPoint
        [endX, endY] = endPoint
        [startX, endX] = [endX, startX] if startX > endX
        [startY, endY] = [endY, startY] if startY > endY

        @_restoreStatus startX, endX, startY, endY, statusNumber
        @_handleCellSelection startX, endX, startY, endY, isSelecting, statusNumber

      comfirmCellsUpdate: ->
        @changedCells = {}
        @hasValidTimes = @checkTimeValidity()
        @onValidTimesChange() if @onValidTimesChange?

      checkTimeValidity: ->
        return true unless @isOpened
        for date in @dates
          return false if _.filter(date.times, (time) -> time.isOpened()).length == 0
        return true

      toEventDates: (useIdForEventDate=false) ->
        eventDates = []
        isToggled = (t) => if @isOpened then t.isOpened() else t.isAvailable()
        for dateInfo in @dates
          times = ((if isToggled t then '1' else '0') for t in dateInfo.times).join ''
          eventDate =
            date: dateInfo.date.toString 'yyyy/MM/dd'
            times: times

          if useIdForEventDate
            eventDate.eventDateId = dateInfo.id if dateInfo.id?
          else
            eventDate.id = dateInfo.id if dateInfo.id?
            eventDate.eventDateId = dateInfo.eventDateId if dateInfo.eventDateId?

          eventDates.push eventDate
        eventDates
