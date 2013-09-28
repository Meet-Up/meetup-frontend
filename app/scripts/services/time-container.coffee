angular.module('meetupServices')
  .factory 'TimeContainer',  (EventDate, DateHelper, CELLS_PER_DAY) ->

    getDateKey = (date) -> date.toString 'yyyyMMdd'

    class TimeCell
      @OPENED:     0x01
      @AVAILABLE:  0x02

      status: 0

      constructor: (@index, opened, available) ->
        @setOpened opened ? false
        @setAvailable available ? false

      updateStatus: (active, type) ->
        if active then @status |= type else @status &= ~type
      getStatus: (type) -> @status & type != 0

      isOpened: -> @getStatus TimeCell.OPENED
      isAvailable: -> @getStatus TimeCell.AVAILABLE
      setOpened: (b) -> @updateStatus b, TimeCell.OPENED
      setAvailable: (b) -> @updateStatus b, TimeCell.AVAILABLE


    class TimeContainer
      constructor: (eventDates) ->
        @reset eventDates

      rows: -> [@minRow..@maxRow]

      reset: (eventDates) ->
        @dates = {}
        [@minRow, @maxRow] = [CELLS_PER_DAY - 1, 0]
        for eventDate in eventDates
          [start, end] = @_getInterval eventDate
          @_initializeDates start, end
          @_initializeDateStatus start, end

      _getInterval: (eventDate) ->
        if eventDate instanceof EventDate
          [eventDate.start, eventDate.end]
        else
          start = eventDate.clone().set({ hour: 0, minute: 0})
          end = eventDate.clone().set({ hour: 23, minute: 59})
          [start, end]

      _initializeDates: (dates...) ->
        for date in dates
          key = getDateKey date
          continue if key of @dates
          @dates[key] = (new TimeCell(i) for i in [0..CELLS_PER_DAY - 1])

      _initializeDateStatus: (start, end) ->
        key = getDateKey start
        startInfo = DateHelper.getDateIndexInfo start
        endInfo = DateHelper.getDateIndexInfo end
        endIndex = endInfo.index - (if endInfo.exact then 1 else 0)
        for i in [startInfo.index..endIndex]
          @dates[key][i].setOpened true

        @minRow = startInfo.index if startInfo.index < @minRow
        @maxRow = endIndex if endIndex > @maxRow
