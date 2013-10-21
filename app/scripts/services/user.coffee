angular.module('meetAppServices')
  .factory 'User', (railsResourceFactory, UserSerializer, API_URL) ->
    User = railsResourceFactory
      url: "#{API_URL}/events/{{eventToken}}/users"
      name: 'user'
      serializer: 'UserSerializer'

    User
