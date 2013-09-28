angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, Event, EventDate, DateHelper) ->

    $scope.event = new Event({ datesIndexes: {}, dates: [] })

    $scope.saveEvent = ->
      $scope.event.save()

    $scope.toggleDate = (date) ->
      date = date.clone().set { hour: 0, minute: 0 }
      if $scope.event.hasDate date
        delete $scope.event.removeDate date
      else
        end = date.clone().set { hour: 23, minute: 59}
        $scope.event.addDate date, end
