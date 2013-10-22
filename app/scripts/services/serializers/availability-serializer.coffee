angular.module('MeetAppServices')
  .factory 'AvailabilitySerializer', (railsSerializer) ->
    railsSerializer ->
      @exclude 'date', 'createdAt', 'updatedAt'
      return
