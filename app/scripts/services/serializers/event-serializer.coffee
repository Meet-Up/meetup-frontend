angular.module('MeetAppServices')
  .factory 'EventSerializer', (railsSerializer) ->
    railsSerializer ->
      @nestedAttribute 'dates'
      @exclude 'created_at', 'updated_at', 'id', 'token'
