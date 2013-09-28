angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, Event, EventDate, DateHelper, calendarModel) ->

    $scope.event = new Event({ datesIndexes: {}, dates: [] })

    $scope.calendar = calendarModel

    $scope.saveEvent = ->
      $scope.event.save()
