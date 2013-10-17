angular.module('meetupDirectives')
  .directive 'calendar', ($parse, DateHelper, DEVICE) ->
    restrict: 'E'
    replace: true
    transclude: false
    templateUrl: "partials/#{DEVICE}/calendar/full.html"

    controller: ($scope, $element, $attrs) ->
      $scope.calendar.noToolbar = $parse($attrs.noToolbar)() ? false
      $scope.calendar.toggable = $parse($attrs.toggable)() ? false
      $scope.calendar.allowPastDates = $parse($attrs.allowPastDates)() ? true
