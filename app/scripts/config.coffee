angular.module('MeetAppConfig', [])
  .config(($provide, $httpProvider) ->
    device = if $(window).width() >= 1024 then 'desktop' else 'mobile'
    $provide.constant 'APP_URL', 'http://localhost:9000/#'
    $provide.constant 'API_URL', 'http://localhost:3000'
    $provide.constant 'CELLS_PER_DAY', 48
    $provide.constant 'DEVICE', device
    $provide.constant 'DAYS_PER_PAGE', if device == 'desktop' then 7 else 5
    $provide.constant 'DEBUG', false
  ).run ($rootScope, $state, DEVICE) ->
    $rootScope.device = DEVICE
