angular.module('meetupServices')
  .factory 'TimeContainer',  (EventDate, CELLS_PER_DAY) ->

    getDateKey = (date) -> date.toString 'yyyyMMdd'

    class TimeCell
      @OPENED:     0x01
      @AVAILABLE:  0x02

      status: 0

      constructor: (opened, available) ->
        @setOpened opened ? false
        @setAvailable available ? false

      setStatus: (active, type) ->
        if active then @status |= type else @status &= ~type
      getStatus: (type) -> @status & type != 0

      isOpened: -> @getStatus @OPENED
      isAvailable: -> @getStatus @AVAILABLE
      setOpened: (b) -> @updateStatus b, TimeCell.OPENED
      setAvailable: (b) -> @updateStatus b, TimeCell.AVAILABLE


    class TimeContainer
      constructor: (eventDates) ->
        @reset eventDates

      reset: (eventDates) ->
        @dates = {}
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
          @dates[key] = (new TimeCell() for _ in [1..CELLS_PER_DAY])

      _initializeDateStatus: (start, end) ->
        key = getDateKey start
        startInfo = DateHelper.getDateIndexInfo start
        endInfo = DateHelper.getDateIndexInfo start
        endIndex = end.index - (if endInfo.exact then 1 else 0)
        for i in [startInfo.index..endIndex]
          @dates[key][i].setOpened true
