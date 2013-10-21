
angular.module('MeetAppControllers')
  .controller 'EventCtrl', ($scope, event, TimeContainer, createDialog, User, DEBUG) ->
    $scope.event = event
    $scope.timeContainer = TimeContainer.fromEventDates(event.dates)

    $scope.user = new User({eventToken: $scope.event.token })

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

    $scope.openAvailabilites = ->
      $scope.timeEditContainer = TimeContainer.fromEventDates(event.dates)
      createDialog $scope, 'partials/desktop/events/availabilities-modal.html'

    $scope.saveAvailabities = ->
      $scope.user.availabilities = $scope.timeEditContainer.toEventDates()
      unless DEBUG
        $scope.user.save().then (user) ->
          console.log user
