angular.module('MeetAppServices')
  .factory 'User', (railsResourceFactory, UserSerializer, API_URL) ->
    User = railsResourceFactory
      url: "#{API_URL}/events/{{eventToken}}/participants"
      name: 'participant'
      serializer: 'UserSerializer'

    User
