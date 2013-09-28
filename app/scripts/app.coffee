angular.module('meetupApp', [
  'ui.router'
  'meetupControllers'
  'meetupDirectives'
  'meetupFilters'
]).config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider
    .state('home', {
      url: '/'
      templateUrl: 'views/main.html'
      controller: 'HomeCtrl'
      data:
        titleBar:
          hasCreate: true
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
      data:
        titleBar:
          hasNext: true
          nextState: 'create-event.select-time'
    })
    .state('create-event.select-time', {
      url: '/select-time'
      templateUrl: 'partials/create-event/time-selection.html'
      data:
        titleBar:
          hasPrevious: true
          previousState: 'create-event.index'
    })
