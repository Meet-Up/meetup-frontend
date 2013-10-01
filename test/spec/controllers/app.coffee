describe 'Controller: AppCtrl', () ->

  # load the controller's module
  beforeEach module 'meetupControllers'

  AppCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    AppCtrl = $controller 'AppCtrl', {
      $scope: scope
    }

  it 'should be true', ->
    expect(true).toBe true
