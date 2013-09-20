
describe 'Controller: MainCtrl', () ->

  # load the controller's module
  beforeEach module 'meetupControllers'

  MainCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainCtrl = $controller 'MainCtrl', {
      $scope: scope
    }

  it 'should be true', () ->
    expect(true).toBe true
