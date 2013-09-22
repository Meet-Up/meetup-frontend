angular.module('meetupControllers', ['meetupServices', 'meetupDirectives'])
  .controller 'MainCtrl', ($scope) ->
    $scope.device = if $(window).width() < 1000 then 'mobile' else 'desktop'
