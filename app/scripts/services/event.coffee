angular.module('meetupServices')
  .factory 'Event', (railsResourceFactory, railsSerializer, EventSerializer, API_PATH) ->
    railsResourceFactory
      url: API_PATH + '/events'
      name: 'event'
      serializer: EventSerializer
