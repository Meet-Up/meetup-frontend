angular.module('MeetAppServices')
  .factory 'UserSerializer', (railsSerializer) ->
    railsSerializer ->
      @nestedAttribute 'availabilities'
      @exclude 'eventToken'
