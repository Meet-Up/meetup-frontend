# Setup the variables and rename the file 'config.local.coffee'

angular.module('MeetAppLocalConfig', [])
  .config ($provide) ->
    $provide.constant 'LOCAL_CONFIG',
      APP_URL: 'http://localhost:9000/#'
      API_URL: 'http://localhost:3000'
      DEBUG: false
