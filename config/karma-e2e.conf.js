// Karma configuration
// http://karma-runner.github.io/0.10/config/configuration-file.html

module.exports = function(config) {
  config.set({
    // base path, that will be used to resolve files and exclude
    basePath: '../',

    // testing framework to use (jasmine/mocha/qunit/...)
    frameworks: ['ng-scenario'],

    // list of files / patterns to load in the browser
    files: [
      // 'app/bower_components/angular-scenario/angular-scenario.js',
      'app/bower_components/angular/angular.js',
      'app/bower_components/angular-mocks/angular-mocks.js',
      'app/bower_components/angularjs-rails-resource/angularjs-rails-resource.js',
      'app/bower_components/jquery/jquery.js',
      'app/vendors/datejs/date.js',
      'app/scripts/app.coffee',
      'app/scripts/config.coffee',
      'app/scripts/services/main.coffee',
      'app/scripts/filters/main.coffee',
      'app/scripts/directives/main.coffee',
      'app/scripts/controllers/main.coffee',
      'app/scripts/*.coffee',
      'app/scripts/**/*.coffee',
      'test/e2e/**/*.coffee'
    ],


    // list of files / patterns to exclude
    exclude: [],

    // web server port
    port: 8082,

    // level of logging
    // possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: false,


    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers: ['Chrome'],


    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: false,

    // URL root prevent conflicts with the site root
    urlRoot: '/__e2e/',

    // Uncomment the following lines if you are using grunt's server to run the tests
    proxies: {
      '/': 'http://localhost:9000/'
    }

  });
};
