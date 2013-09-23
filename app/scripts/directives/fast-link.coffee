angular.module('meetupDirectives')
  .directive 'fastLink', ($parse, $location, $state) ->
    restrict: 'A'
    link: ($scope, $elem, $attr) ->
      $elem.fastClick (e) =>
        if 'href' of $attr
          href = $attr.href.replace '#', ''
          $scope.$apply () -> $location.path href
        else if 'uiSref' of $attr
          $scope.$apply () -> $state.go $attr.uiSref

