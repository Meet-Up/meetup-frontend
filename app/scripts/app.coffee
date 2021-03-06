angular.module('MeetAppApp', [
  'ui.router'
  'MeetAppControllers'
  'MeetAppDirectives'
  'MeetAppFilters'
  'MeetAppConfig'
]).config(($stateProvider, $urlRouterProvider, DEVICE) ->

  commonStates =
    home:
      url: '/'
      templateUrl: 'views/home.html'
      controller: 'HomeCtrl'
      data:
        titleBar:
          hasCreate: true

  resolveEvent =
    event: ['$stateParams', 'eventContainer', 'DEBUG', ($stateParams, eventContainer, DEBUG) ->
      if DEBUG
        {
          title: 'foo'
          duration: 1
          dates: []
        }
      else
        eventContainer.getEvent $stateParams.token
    ]


  desktopStates =
    'create-event':
      abstract: true
      url: '/create-event'
      controller: 'CreateEventCtrl'
      templateUrl: 'views/desktop/create-event.html'

    'create-event.index':
      url: ''
      templateUrl: 'partials/desktop/create-event/creation.html'

    'create-event.confirm':
      url: '/confirm'
      controller: 'ConfirmEventCtrl'
      templateUrl: 'partials/desktop/create-event/confirmation.html'

    events:
      url: '/events/:token'
      templateUrl: 'views/desktop/events.html'
      controller: 'EventCtrl'
      resolve: resolveEvent

  mobileStates =
    'create-event':
      url: '/create-event'
      templateUrl: 'views/mobile/create-event.html'
      controller: 'CreateEventCtrl'
      abstract: true
    'create-event.index':
      url: ''
      templateUrl: 'partials/mobile/create-event/general.html'
      controller: 'EventInfoCtrl'
      data:
        titleBar:
          hasNext: true
          nextDisabled: true
          nextState: 'create-event.select-time'
    'create-event.select-time':
      url: '/select-time'
      templateUrl: 'partials/mobile/create-event/time-selection.html'
      controller: 'SelectTimeCtrl'
      data:
        titleBar:
          hasPrevious: true
          hasNext: true
          nextDisabled: true
          nextText: '作成'
          nextEvent: 'createEvent'
    'create-event.confirm':
      url: '/confirm'
      templateUrl: 'partials/mobile/create-event/confirmation.html'
      controller: 'ConfirmEventCtrl'
      data:
        titleBar:
          hasPrevious: true
          hasNext: false

    events:
      url: '/events/:token'
      templateUrl: 'views/mobile/events.html'
      controller: 'EventCtrl'
      resolve: resolveEvent

  otherStates = if DEVICE == 'desktop' then desktopStates else mobileStates

  for stateName, stateData of _.extend({}, commonStates, otherStates)
    $stateProvider.state stateName, stateData

  $urlRouterProvider.otherwise '/'

).run ($rootScope, $state) ->
  $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
    console.log error
