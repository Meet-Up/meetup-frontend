angular.module('meetupApp', [
  'ui.router'
  'meetupControllers'
  'meetupDirectives'
  'meetupFilters'
  'meetupConfig'
]).config(($stateProvider, $urlRouterProvider, DEVICE) ->

  commonStates =
    home:
      url: '/'
      templateUrl: 'views/home.html'
      controller: 'HomeCtrl'
      data:
        titleBar:
          hasCreate: true

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
      templateUrl: 'partials/desktop/create-event/confirmation.html'

    events:
      url: '/events/:token'
      templateUrl: 'views/desktop/events.html'
      controller: 'EventCtrl'
      resolve:
        event: ($stateParams, eventContainer, DEBUG) ->
          if DEBUG
            {
              title: 'foo'
              duration: 1
              dates: []
            }
          else
            eventContainer.getEvent $stateParams.token

  mobileStates =
    'create-event':
      url: '/create-event'
      templateUrl: 'views/mobile/create-event.html'
      controller: 'CreateEventCtrl'
      abstract: true
    'create-event.index':
      url: ''
      templateUrl: 'partials/mobile/create-event/general.html'
      data:
        titleBar:
          hasNext: true
          nextDisabled: true
          nextState: 'create-event.select-time'
    'create-event.selection-time':
      url: '/select-time'
      templateUrl: 'partials/mobile/create-event/time-selection.html'
      data:
        titleBar:
          hasPrevious: true
          hasNext: true
          nextDisabled: true
          nextState: 'create-event.confirm'
    'create-event.confirm':
      url: '/confirm'
      templateUrl: 'partials/mobile/create-event/confirmation.html'
      data:
        titleBar:
          hasPrevious: true
          hasNext: false

  otherStates = if DEVICE == 'desktop' then desktopStates else mobileStates

  for stateName, stateData of _.extend({}, commonStates, otherStates)
    $stateProvider.state stateName, stateData

  $urlRouterProvider.otherwise '/'

).run ($rootScope, $state) ->
  $rootScope.$on '$stateChangeStart', (event, toState, toParams) ->
    # console.log event, toState, toParams
