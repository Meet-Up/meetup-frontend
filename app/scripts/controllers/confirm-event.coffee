angular.module('MeetAppControllers')
  .controller 'ConfirmEventCtrl', ($scope, $state) ->
    unless $scope.event? && $scope.event.token?
      $state.go '^.index'
      return
