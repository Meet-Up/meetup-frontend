angular.module('meetupControllers')
  .controller 'HomeCtrl', ($scope) ->
    $scope.features = [
      title: '1.世界最速'
      template: 'partials/feature-boxes/fastest.html'
    ,
      title: '2.ユビキタス'
      template: 'partials/feature-boxes/ubiquitous.html'
    ,
      title: '3.直感的操作'
      template: 'partials/feature-boxes/intuitive.html'
    ]

    $scope.usages = [
      title: '1.イベントの作成'
      template: 'partials/usage/event-creation.html'
    ,
      title: '2.予定を入力する'
      template: 'partials/usage/time-selection.html'
    ,
      title: '3.日時を決定！'
      template: 'partials/usage/confirmation.html'
    ]
