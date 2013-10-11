angular.module('meetupServices')
  .factory 'eventContainer', (Event) ->

    class EventContainer
      container: {}

      addEvent: (event) ->
        @container[event.token] = event if event.token?

      getEvent: (token) ->
        if token of @container
          @container[token]
        else
          Event.get({ token: token }).then (evt) ->
            evt

    new EventContainer()
