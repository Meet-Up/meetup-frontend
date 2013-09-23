angular.module('meetupServices')
  .factory 'Event', (railsResourceFactory, railsSerializer, EventSerializer, DateHelper, API_PATH) ->
    Event = railsResourceFactory
      url: API_PATH + '/events'
      name: 'event'
      serializer: 'EventSerializer'

    Event::minTime = ->
      startDates = (DateHelper.getTimeOnly(date.start) for date in @dates)
      new Date(Math.min.apply null, startDates)

    Event::maxTime = ->
      endDates = (DateHelper.getTimeOnly(date.end) for date in @dates)
      new Date(Math.max.apply null, endDates)

    Event::neededRowsNumber = ->
      return 0 unless @dates? && @dates.length > 0
      DateHelper.getCellsNumberInInterval @minTime(), @maxTime()

    Event
