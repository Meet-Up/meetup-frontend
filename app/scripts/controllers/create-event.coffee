angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, Event, EventDate, DateHelper) ->

    $scope.event = new Event({ datesIndexes: {}, dates: [] })

    $scope.saveEvent = ->
      $scope.event.save()
