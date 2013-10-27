angular.module('MeetAppConfig', ['MeetAppLocalConfig'])
  .config(($provide, LOCAL_CONFIG) ->
    device = if $(window).width() >= 1024 then 'desktop' else 'mobile'

    defaults =
      APP_URL: 'http://localhost:9000/#'
      API_URL: 'http://localhost:3000'
      CELLS_PER_DAY: 48
      DEVICE: device
      DAYS_PER_PAGE: if device == 'desktop' then 7 else 5
      RECOMMENDATIONS_NUMBER: 5
      DEBUG: false

    for key of defaults
      value = if LOCAL_CONFIG[key]? then LOCAL_CONFIG[key] else defaults[key]
      $provide.constant key, value

  ).run ($rootScope, $state, DEVICE) ->
    $rootScope.device = DEVICE
