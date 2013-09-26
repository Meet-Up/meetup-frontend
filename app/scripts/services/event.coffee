angular.module('meetupServices')
  .factory 'Event', (railsResourceFactory, railsSerializer, EventDate, EventSerializer, DateHelper, API_PATH) ->
    Event = railsResourceFactory
      url: API_PATH + '/events'
      name: 'event'
      serializer: 'EventSerializer'

    datesIndexes = {}

    Event::minTime = ->
      startDates = (DateHelper.getTimeOnly(date.start) for date in @dates)
      new Date(Math.min.apply null, startDates)

    Event::maxTime = ->
      endDates = (DateHelper.getTimeOnly(date.end) for date in @dates)
      new Date(Math.max.apply null, endDates)

    Event::neededRowsNumber = ->
      return 0 unless @dates? && @dates.length > 0
      DateHelper.getCellsNumberInInterval @minTime(), @maxTime()

    Event::neededRowsArray = ->
      new Array(@neededRowsNumber())

    Event::dates = []

    Event::dateContainer = (date) ->
      datesIndexes[date.toISOString()]

    Event::addDate = (date, end) ->
      eventDate = new EventDate()
      eventDate.start = date
      eventDate.end = end ? date.clone().addHours 2
      @addEventDate eventDate

    Event::addEventDate = (eventDate) ->
      key = eventDate.start.toISOString()
      datesIndexes[key] = @dates.length
      @dates.push eventDate

    Event::hasDate = (date) ->
      if date instanceof EventDate
        date = date.start
      date.toISOString() of datesIndexes

    Event::removeDate = (date) ->
      key = if date instanceof Date
              date.toISOString()
            else if date instanceof EventDate
              date.start.toISOString()
            else
              throw new Exception('unsupported type')
      index = datesIndexes[key]
      @dates.splice index, 1
      delete datesIndexes[key]

    Event
