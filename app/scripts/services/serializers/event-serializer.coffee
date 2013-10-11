angular.module('meetupServices')
  .factory 'EventSerializer', (railsSerializer) ->
    railsSerializer ->
      @nestedAttribute 'dates'
