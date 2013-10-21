angular.module('meetAppServices')
  .factory 'UserSerializer', (railsSerializer) ->
    railsSerializer ->
      @nestedAttribute 'availabilities'
