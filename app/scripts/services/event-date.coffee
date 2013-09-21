angular.module('meetupServices')
  .factory 'EventDate', (railsResourceFactory, railsSerializer) ->
    railsResourceFactory
      url: '/events/:id/dates'
      name: 'event_date'
