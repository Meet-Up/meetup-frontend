angular.module('meetupFrontendApp')
  .directive 'backButton', () ->
    restrict: 'A'

    link: (scope, elem, attrs) ->
      goBack = ->
        history.back()
        scope.$apply()
      elem.bind 'click', goBack

