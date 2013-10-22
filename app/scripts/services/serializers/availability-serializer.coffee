angular.module('MeetAppServices')
  .factory 'AvailabilitySerializer', (railsSerializer) ->
    railsSerializer ->
      @only 'times', 'eventDateId', 'id'
      return
