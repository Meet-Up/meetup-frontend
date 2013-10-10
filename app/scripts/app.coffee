angular.module('meetupApp', [
  'ui.router'
  'meetupControllers'
  'meetupDirectives'
  'meetupFilters'
  'meetupConfig'
]).config(($stateProvider, $urlRouterProvider, DEVICE) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider
    .state('home', {
      url: '/'
      templateUrl: "views/#{DEVICE}/main.html"
      controller: 'HomeCtrl'
      data:
        titleBar:
          hasCreate: true
    })
    .state('create-event', {
      url: '/create-event'
      templateUrl: "views/#{DEVICE}/create-event.html"
      controller: 'CreateEventCtrl'
      abstract: true
    })
    .state('create-event.index', {
      url: ''
      templateUrl: "partials/#{DEVICE}/create-event/general.html"
      data:
        titleBar:
          hasNext: true
          nextDisabled: true
          nextState: 'create-event.select-time'
    })
    .state('create-event.select-time', {
      url: '/select-time'
      templateUrl: "partials/#{DEVICE}/create-event/time-selection.html"
      data:
        titleBar:
          hasPrevious: true
          previousState: 'create-event.index'
    })
    .state('events', {
      url: '/events'
      templateUrl: "views/#{DEVICE}/events.html"
      controller: 'CreateEventCtrl'
    })
  ).run ($rootScope, DEVICE) ->
    $rootScope.device = DEVICE

