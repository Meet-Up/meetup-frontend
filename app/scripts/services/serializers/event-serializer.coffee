angular.module('MeetAppServices')
  .factory 'EventSerializer', (railsSerializer) ->
    railsSerializer ->
      @nestedAttribute 'dates'
