angular.module('meetupDirectives')
  .directive 'selectTime', ($parse) ->
    restrict: 'E'
    replace: true
    transclude: false
    templateUrl: 'partials/create-event/select-time.html'
    controller: ($scope, $element, $attrs) ->
      $scope.rows = $scope.event.neededRowsArray()
