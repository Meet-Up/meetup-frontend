angular.module('meetupServices')
  .factory 'EventSerializer', (railsSerializer, EventDate) ->
    railsSerializer ->
      @nestedAttribute 'dates'
