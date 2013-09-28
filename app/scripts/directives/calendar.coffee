angular.module('meetupDirectives')
  .directive 'calendar', ($parse, DateHelper) ->
    restrict: 'E'
    replace: true
    transclude: false
    templateUrl: 'partials/calendar/full.html'
    controller: ($scope, $element, $attrs) ->
      setDate = (date) ->
        calendar.date = date
        calendar.weeks = DateHelper.getWeeksInMonth date

      $scope.daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S']

      $scope.noToolbar = $parse($attrs.noToolbar)() ? false

      calendar = $scope.$parent.calendar ?=
        toggable: $parse($attrs.toggable)() ? false
        selectedDates: {}

      setDate Date.today()

      $scope.toLastMonth = ->
        newDate = calendar.date.last().month()
        setDate newDate

      $scope.toNextMonth = ->
        newDate = calendar.date.next().month()
        setDate newDate
