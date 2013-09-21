angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, Event) ->
    $scope.event = new Event()
