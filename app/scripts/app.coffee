angular.module('meetupApp', [
  'meetupControllers'
  'meetupDirectives'
]).config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/create-event',
        templateUrl: 'views/create-event.html'
        controller: 'CreateEventCtrl'
      .otherwise
        redirectTo: '/'
