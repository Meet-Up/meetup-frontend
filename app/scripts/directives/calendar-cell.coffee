angular.module('meetupDirectives')
  .directive 'calendarCell', ($parse) ->
    calendar = {}

    generateKey = (date) -> date.toString 'yyyyMMdd'

    addStatusClass = (cellDate, $elem) ->
      status = cellDate.getMonth() - calendar.date.getMonth()
      if status < 0 then $elem.addClass 'previous-month'
      else if status == 0 then $elem.addClass 'current-month'
      else $elem.addClass 'next-month'
      $elem.addClass 'past' if cellDate < Date.today()

    toggleDate = (date, $elem) ->
      dateKey = generateKey date
      if dateKey of calendar.selectedDates
        delete calendar.selectedDates[dateKey]
      else
        calendar.selectedDates[dateKey] = date
      updateClass dateKey of calendar.selectedDates, $elem

    updateClass = (isSelected, $elem) ->
      if isSelected
        $elem.addClass 'selected-true'
      else
        $elem.removeClass 'selected-true'

    return {
      restrict: 'A'

      link: ($scope, $elem, $attr) ->
        calendar = $scope.calendar
        $elem.addClass 'day-cell'

        cellDate = $parse($attr.calendarCell)($scope)

        addStatusClass cellDate, $elem

        if calendar.toggable
          if calendar.allowPastDates || cellDate >= Date.today()
            $elem.fastClick (event) ->
              toggleDate cellDate, $elem
              $scope.$apply()
            dateKey = generateKey cellDate
            updateClass dateKey of calendar.selectedDates, $elem
    }
