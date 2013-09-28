angular.module('meetupDirectives')
  .directive 'calendar', ($parse, DateHelper) ->
    restrict: 'E'
    replace: true
    transclude: false
    templateUrl: 'partials/calendar/full.html'
    controller: ($scope, $element, $attrs) ->
      setDate = (date) ->
        $scope.calendar.date = date
        $scope.calendar.weeks = DateHelper.getWeeksInMonth date

      $scope.daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S']
      $scope.hasToolbar = true

      $scope.calendar ?=
        toggable: true
        selectedDates: {}

      setDate Date.today()

      $scope.toLastMonth = ->
        newDate = $scope.calendar.date.last().month()
        setDate newDate

      $scope.toNextMonth = ->
        newDate = $scope.calendar.date.next().month()
        setDate newDate
