angular.module('meetupDirectives')
  .directive 'calendarCell', ($parse) ->

    generateKey = (date) -> date.toString 'yyyyMMdd'

    addStatusClass = (cellDate, $scope, $elem) ->
      scopeDate = $scope.calendar.date
      status = cellDate.getMonth() - scopeDate.getMonth()
      if status < 0 then $elem.addClass 'past'
      else if status == 0 then $elem.addClass 'current'
      else $elem.addClass 'future'

    toggleDate = (date, calendar, $elem) ->
      dateKey = generateKey date
      if dateKey of calendar.selectedDates
        delete calendar.selectedDates[dateKey]
      else
        calendar.selectedDates[dateKey] = date
      updateClass dateKey of calendar.selectedDates, $elem

    updateClass = (isSelected, $elem) ->
      if isSelected
        $elem.addClass 'selected'
      else
        $elem.removeClass 'selected'

    return {
      restrict: 'A'

      link: ($scope, $elem, $attr) ->
        return unless $scope.calendar?

        calendar = $scope.calendar

        $elem.addClass 'day-cell'

        cellDate = $parse($attr.calendarCell)($scope)

        addStatusClass cellDate, $scope, $elem

        if $scope.calendar.toggable
          $elem.fastClick (event) ->
            toggleDate cellDate, calendar, $elem
          dateKey = generateKey cellDate
          updateClass dateKey of calendar.selectedDates, $elem
    }
