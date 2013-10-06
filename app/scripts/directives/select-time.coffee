angular.module('meetupDirectives')
  .directive 'selectTime', ($parse, $state, TimeContainer) ->
    getDates = ($scope, $attrs) ->
      selectionTarget = $attrs.selectionTarget ? 'possibilities'
      if selectionTarget == 'availabilities'
        return $scope.event.dates if 'event' of $scope
        $state.go 'home'
      else if selectionTarget == 'possibilities'
        if 'calendar' of $scope
          dates = (date for k, date of $scope.calendar.selectedDates)
          return dates if dates.length > 0
        $state.go 'create-event.index'
      return

    restrict: 'E'
    replace: true
    transclude: false
    templateUrl: 'partials/create-event/select-time.html'

    controller: ($scope, $element, $attrs) ->
      dates = getDates $scope, $attrs
      return unless dates?

      $scope.timeContainer = new TimeContainer(dates)

      $scope.isSelected = (x, y) ->

