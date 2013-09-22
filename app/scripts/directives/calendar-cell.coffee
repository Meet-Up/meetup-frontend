angular.module('meetupDirectives')
  .directive 'calendarCell', ($parse) ->

    addStatusClass = (cellDate, $scope, $elem) ->
      scopeDate = $scope.calendar.date
      status = cellDate.getMonth() - scopeDate.getMonth()
      if status < 0 then $elem.addClass 'past'
      else if status == 0 then $elem.addClass 'current'
      else $elem.addClass 'future'

    addSelectedClass = (key, $scope, $elem) ->
      return unless $scope.event?.dates?
      if $scope.event.dates[key]
        $elem.addClass 'selected'
      else
        $elem.removeClass 'selected'

    restrict: 'A'
    link: ($scope, $elem, $attr) ->
      $elem.addClass 'day-cell'
      return unless $scope.calendar?

      cellDate = $parse($attr.calendarCell)($scope)

      addStatusClass cellDate, $scope, $elem

      key = cellDate.toString('yyMMdd')
      $scope.$watch "event.dates[#{key}]", () ->
        addSelectedClass key, $scope, $elem
      , true
