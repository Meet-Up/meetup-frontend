angular.module('meetupConfig', [])
  .config ($provide) ->
    device = if $(window).width() >= 1024 then 'desktop' else 'mobile'
    $provide.constant 'API_PATH', 'http://localhost:3000'
    $provide.constant 'CELLS_PER_DAY', 48
    $provide.constant 'DEVICE', 'desktop'
    $provide.constant 'DAYS_PER_PAGE', 5
