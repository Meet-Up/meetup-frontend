angular.module('MeetAppDirectives')
  .directive 'fastLink', ($parse, $location, $state, DEVICE) ->
    restrict: 'A'
    link: ($scope, $elem, $attr) ->
      eventName = if DEVICE == 'desktop' then 'click' else 'fastClick'
      $elem[eventName] (e) =>
        e.preventDefault()
        # e.stopImmediatePropagation()
        return if $elem.attr('disabled') == 'disabled' || $elem.hasClass('disabled')
        if 'uiSref' of $attr
          $scope.$apply () -> $state.go $attr.uiSref
        else if 'dsref' of $attr
          $scope.$apply () -> $state.go $attr.dsref
        else if 'href' of $attr
          href = $attr.href.replace '#', ''
          $scope.$apply () -> $location.path href
