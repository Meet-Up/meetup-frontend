angular.module('MeetAppDirectives')
  .directive 'emitOnRender', ($timeout) ->
    restrict: 'A'
    link: ($scope, element, attr) ->
      last = if attr.emitOnRender == 'parent' then $scope.$parent.$last else $scope.$last
      if last
        $timeout ->
          $scope.$emit 'ngRepeatFinished'
