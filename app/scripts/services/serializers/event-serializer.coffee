angular.module('MeetAppServices')
  .factory 'EventSerializer', (railsSerializer) ->
    railsSerializer ->
      @nestedAttribute 'dates'
      @exclude 'createdAt', 'updatedAt', 'token'
      return

