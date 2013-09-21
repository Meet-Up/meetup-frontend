angular.module('meetupServices')
  .factory 'Event', (railsResourceFactory) ->
    railsResourceFactory
      url: '/events'
      name: 'event'
