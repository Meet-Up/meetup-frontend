angular.module('meetupServices')
  .factory 'Event', (railsResourceFactory, railsSerializer, EventSerializer, DateHelper, API_PATH) ->
    Event = railsResourceFactory
      url: API_PATH + '/events'
      name: 'event'
      serializer: 'EventSerializer'

    Event::setDates = (timeContainer) ->
      @dates = []
      for dateInfo in timeContainer.dates
        open_times = ((if t.isOpened() then '1' else '0') for t in dateInfo.times).join ''
        @dates.push
          date: dateInfo.date.toString 'yyyy/MM/dd'
          open_times: open_times

    Event
