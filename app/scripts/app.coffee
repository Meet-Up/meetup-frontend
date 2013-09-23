angular.module('meetupApp', [
  'ui.router'
  'meetupControllers'
  'meetupDirectives'
]).config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider
    .state('home', {
      url: '/'
      templateUrl: 'views/main.html'
      controller: 'HomeCtrl'
    })
    .state('create-event', {
      url: '/create-event'
      templateUrl: 'views/create-event.html'
      controller: 'CreateEventCtrl'
      abstract: true
    })
    .state('create-event.index', {
      url: ''
      templateUrl: 'partials/create-event/general.html'
    })
    .state('create-event.select-time', {
      url: 'select-time'
      templateUrl: 'partials/create-event/select-time.html'
    })
