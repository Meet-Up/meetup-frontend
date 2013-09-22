angular.module('meetupControllers', ['meetupServices', 'meetupDirectives'])
  .controller 'MainCtrl', ($scope) ->
    $scope.$on 'titleBarUpdate', (attrs, properties) ->
      $scope.hasNext = properties.hasNext ? false
      $scope.hasCreate = properties.hasCreate ? false
      $scope.hasPrevious = properties.hasPrevious ? false
