angular.module('meetupControllers', ['meetupServices', 'meetupDirectives'])
  .controller 'MainCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
