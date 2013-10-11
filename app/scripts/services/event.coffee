angular.module('meetupServices')
  .factory 'Event', (railsResourceFactory, railsSerializer, EventSerializer, DateHelper, API_PATH) ->
    Event = railsResourceFactory
      url: API_PATH + '/events'
      name: 'event'
      serializer: 'EventSerializer'

    Event
