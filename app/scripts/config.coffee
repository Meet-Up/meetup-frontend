angular.module('meetupConfig', [])
  .config(($provide, $httpProvider) ->
    device = if $(window).width() >= 1024 then 'desktop' else 'mobile'
    $provide.constant 'APP_URL', 'http://localhost:9000/#'
    $provide.constant 'API_URL', 'http://localhost:3000'
    $provide.constant 'CELLS_PER_DAY', 48
    $provide.constant 'DEVICE', device
    $provide.constant 'DAYS_PER_PAGE', 7
    $provide.constant 'DEBUG', true
  ).run ($rootScope, $state, DEVICE) ->
    $rootScope.device = DEVICE
