angular.module('MeetAppControllers')
  .controller 'EventCtrl', ($scope, event, TimeContainer, createDialog, User, DEBUG) ->
    $scope.event = event
    $scope.timeContainer = TimeContainer.fromEventDates(event.dates)

    $scope.participants = $scope.event.participants ? []

    for participant in $scope.participants
      participant.token = $scope.event.token
      participant.timeContainer = TimeContainer.fromEventDates($scope.event.dates, participant.availabilities)

    $scope.selectedUser = null

    $scope.selectUser = (user) ->
      if user == $scope.selectedUser
        $scope.selectedUser = null
      else
        $scope.selectedUser = user

    $scope.openAvailabilites = (participant) ->
      if participant?
        $scope.timeEditContainer = participant.timeContainer
        $scope.user = participant
        $scope.editing = true
      else
        $scope.timeEditContainer = TimeContainer.fromEventDates($scope.event.dates)
        $scope.user = new User({eventToken: $scope.event.token })
        $scope.editing = false
      createDialog $scope, 'partials/desktop/events/availabilities-modal.html'

    $scope.saveAvailabities = ->
      user = if $scope.editing then $scope.editedUser else $scope.user
      user.availabilities = $scope.timeEditContainer.toEventDates(true)
      unless DEBUG
        user.save().then (savedUser) ->
          console.log savedUser
