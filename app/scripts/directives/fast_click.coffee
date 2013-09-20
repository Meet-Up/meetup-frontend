angular.module('meetupDirectives')
  .directive 'fastClick', ($parse) ->
    restrict: 'A'

    link: ($scope, $elem, $attr) ->
      $elem.fastClick () =>
        fn = $parse $attr['fastClick']
        $scope.$apply () -> fn($scope, { $event: e })
