angular.module('meetupServices')
  .factory 'Event', (railsResourceFactory, railsSerializer, EventSerializer, DateHelper, API_PATH) ->
    Event = railsResourceFactory
      url: API_PATH + '/events'
      name: 'event'
      serializer: 'EventSerializer'

    Event::neededColumns = ->
      return 0 unless @dates? && @dates.length == 0
      startDates = (DateHelper.getTimeOnly(date.start) for date in @dates)
      endDates = (DateHelper.getTimeOnly(date.end) for date in @dates)

    Event
