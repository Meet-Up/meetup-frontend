angular.module('meetupDirectives')
  .directive 'fastClick', ($parse) ->

    ($scope, $elem, $attr) ->
      fn = $parse $attr.fastClick
      $elem.fastClick (event) ->
        return if $elem.attr('disabled') == 'disabled' || $elem.hasClass('disabled')
        $scope.$apply () -> fn($scope, { $event: event })
