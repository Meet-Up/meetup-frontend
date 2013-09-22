angular.module('meetupControllers')
  .controller 'HomeCtrl', ($scope) ->
    $scope.$emit 'titleBarUpdate', {
      hasCreate: true
    }
