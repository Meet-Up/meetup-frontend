angular.module('meetupControllers')
  .controller 'EventCtrl', ($scope, event) ->
    $scope.event = event

