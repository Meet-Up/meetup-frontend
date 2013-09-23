angular.module('meetupControllers', ['ui.router', 'meetupServices', 'meetupDirectives'])
  .controller 'MainCtrl', ($scope, $state) ->
    $scope.$on '$stateChangeSuccess', ->
      if $state.current.data?.titleBar?
        $scope.titleBar = $state.current.data.titleBar
      else
        $scope.titleBar = {}
