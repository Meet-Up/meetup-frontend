angular.module('meetupControllers')
  .controller 'AppCtrl', ($scope, $state) ->
    $scope.$on '$stateChangeSuccess', ->
      if $state.current.data?.titleBar?
        $scope.titleBar = $state.current.data.titleBar
      else
        $scope.titleBar = {}

    $scope.$on 'titleBar.update', (e, attrs) ->
      for key, value of attrs
        $scope.titleBar[key] = value
