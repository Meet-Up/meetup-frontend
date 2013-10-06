angular.module('meetupDirectives')
  .directive 'emitOnRender', ($timeout) ->
    restrict: 'A'
    link: (scope, element, attr) ->
      if scope.$last
        $timeout ->
          scope.$emit 'ngRepeatFinished'
