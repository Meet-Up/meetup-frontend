angular.module('meetupServices')
  .factory 'Event', (railsResourceFactory, railsSerializer, EventSerializer, DateHelper, API_PATH) ->
    Event = railsResourceFactory
      url: API_PATH + '/events'
      name: 'event'
      serializer: 'EventSerializer'

    Event::neededRowsNumber = ->
      return 0 unless @dates? && @dates.length > 0
      startDates = (DateHelper.getTimeOnly(date.start) for date in @dates)
      endDates = (DateHelper.getTimeOnly(date.end) for date in @dates)
      start = new Date(Math.min.apply null, startDates)
      end = new Date(Math.max.apply null, endDates)
      DateHelper.getCellsNumberInInterval start, end

    Event
