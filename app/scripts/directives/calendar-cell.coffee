angular.module('meetupDirectives')
  .directive 'calendarCell', ($parse, calendarModel) ->
    calendar = calendarModel

    generateKey = (date) -> date.toString 'yyyyMMdd'

    addStatusClass = (cellDate, $elem) ->
      status = cellDate.getMonth() - calendar.date.getMonth()
      if status < 0 then $elem.addClass 'past'
      else if status == 0 then $elem.addClass 'current'
      else $elem.addClass 'future'

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
        $elem.addClass 'day-cell'

        cellDate = $parse($attr.calendarCell)($scope)

        addStatusClass cellDate, $elem

        if calendar.toggable
          $elem.fastClick (event) ->
            toggleDate cellDate, $elem
            $scope.$apply()
          dateKey = generateKey cellDate
          updateClass dateKey of calendar.selectedDates, $elem
    }
