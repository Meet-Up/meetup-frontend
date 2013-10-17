angular.module('meetupDirectives')
  .directive 'fastLink', ($parse, $location, $state) ->
    restrict: 'A'
    link: ($scope, $elem, $attr) ->
      $elem.fastClick (e) =>
        e.preventDefault()
        e.stopImmediatePropagation()
        return if $(e.target).attr('disabled') == 'disabled' || $(e.target).hasClass('disabled')
        if 'uiSref' of $attr
          $scope.$apply () -> $state.go $attr.uiSref
        else if 'dsref' of $attr
          $scope.$apply () -> $state.go $attr.dsref
        else if 'href' of $attr
          href = $attr.href.replace '#', ''
          $scope.$apply () -> $location.path href
