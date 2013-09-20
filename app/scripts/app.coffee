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
      .when '/create-event/select-dates',
        templateUrl: 'views/select-dates.html'
        controller: 'SelectDatesCtrl'
      .otherwise
        redirectTo: '/'
