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
      templateUrl: 'views/desktop/main.html'
      controller: 'HomeCtrl'
      data:
        titleBar:
          hasCreate: true
    })
    .state('create-event', {
      url: '/create-event'
      templateUrl: 'views/desktop/create-event.html'
      controller: 'CreateEventCtrl'
      abstract: true
    })
    .state('create-event.index', {
      url: ''
      templateUrl: 'partials/desktop/create-event/general.html'
      data:
        titleBar:
          hasNext: true
          nextDisabled: true
          nextState: 'create-event.select-time'
    })
    .state('create-event.select-time', {
      url: '/select-time'
      templateUrl: 'partials/desktop/create-event/time-selection.html'
      data:
        titleBar:
          hasPrevious: true
          previousState: 'create-event.index'
    })
