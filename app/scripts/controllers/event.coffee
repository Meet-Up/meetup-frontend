angular.module('meetupControllers')
  .controller 'EventCtrl', ($scope, $state, $stateParams, Event, TimeContainer, $filter) ->

    if $state.current.data?.event?
      $scope.event = $state.current.data.event
    else
      Event.get({ token: $stateParams.token }).then (evt) ->
        $scope.event = evt

