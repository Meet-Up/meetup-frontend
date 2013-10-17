angular.module('meetupControllers')
  .controller 'EventCtrl', ($scope, event, TimeContainer, DEBUG) ->
    $scope.event = event
    $scope.timeContainer = TimeContainer.fromEventDates(event.dates)

    $scope.persons = [
      'Daniel'
      'Soneoka'
      'Hajime'
    ]

    $scope.selectedPerson = ''

    $scope.selectPerson = (person) ->
      if person == $scope.selectedPerson
        $scope.selectedPerson = ''
      else
        $scope.selectedPerson = person