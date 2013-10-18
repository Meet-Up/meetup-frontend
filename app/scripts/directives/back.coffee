angular.module('MeetAppDirectives')
  .directive 'backButton', () ->
    restrict: 'A'

    link: ($scope, $elem, $attrs) ->
      goBack = ->
        history.back()
        $scope.$apply()
      $elem.fastClick goBack

