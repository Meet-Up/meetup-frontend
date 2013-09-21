angular.module('meetupServices')
  .factory 'EventSerializer', (railsSerializer, EventDate) ->
    railsSerializer ->
      @nestedAttribute 'eventDates'
      @resource 'eventDates', 'EventDate'
