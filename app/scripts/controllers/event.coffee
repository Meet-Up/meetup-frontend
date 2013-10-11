angular.module('meetupControllers')
  .controller 'EventCtrl', ($scope, event, TimeContainer) ->
    $scope.event = event
    $scope.timeContainer = TimeContainer.fromEventDates(event.dates)


