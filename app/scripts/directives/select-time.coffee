angular.module('meetupDirectives')
  .directive 'selectTime', ($parse, $location, TimeContainer) ->
    getDates = ($scope, $attrs) ->
      selectionTarget = $attrs.selectionTarget ? 'possibilities'
      if selectionTarget == 'availabilities'
        if 'event' of $scope
          return $scope.event.dates
        else
          $location.path '/'
          return
      else if selectionTarget == 'possibilities'
        if 'calendar' of $scope
          return (date for k, date of $scope.calendar.selectedDates)
        else
          $location.path '/create-event'
          return

    restrict: 'E'
    replace: true
    transclude: false
    templateUrl: 'partials/create-event/select-time.html'
    controller: ($scope, $element, $attrs) ->
      dates = getDates $scope, $attrs
      return unless dates?
      console.log dates

      timeContainer = new TimeContainer(dates)

      console.log timeContainer
