angular.module('meetupServices')
  .factory 'UserSerializer', (railsSerializer) ->
    railsSerializer ->
      @nestedAttribute 'availabilities'
