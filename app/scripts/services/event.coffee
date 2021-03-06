angular.module('MeetAppServices')
  .factory 'Event', (railsResourceFactory, EventSerializer, API_URL, APP_URL) ->
    Event = railsResourceFactory
      url: "#{API_URL}/events/{{token}}"
      name: 'event'
      serializer: 'EventSerializer'

    Event::getUrl = ->
      @$url().replace API_URL, APP_URL

    Event
