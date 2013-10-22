angular.module('MeetAppServices')
  .factory 'UserSerializer', (railsSerializer, AvailabilitySerializer) ->
    railsSerializer ->
      @nestedAttribute 'availabilities'
      @serializeWith 'availabilities', 'AvailabilitySerializer'
      @only 'name', 'password', 'availabilities', 'availabilities_attributes'
      return
