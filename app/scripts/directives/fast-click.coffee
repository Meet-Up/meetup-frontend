angular.module('meetupDirectives')
  .directive 'fastClick', ($parse) ->

    ($scope, $elem, $attr) ->
      fn = $parse $attr.fastClick
      $elem.fastClick (event) ->
        return if $attr.disabled
        $scope.$apply () -> fn($scope, { $event: event })
