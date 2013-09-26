angular.module('meetupDirectives')
  .directive 'selectTime', ($parse) ->
    restrict: 'E'
    replace: true
    transclude: false
    templateUrl: 'partials/create-event/select-time.html'
    controller: ($scope, $element, $attrs) ->
      console.log $scope.event


