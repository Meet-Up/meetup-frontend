angular.module('MeetAppControllers')
  .controller 'EventCtrl', ($scope, event, TimeContainer, AvailabilityContainer, createDialog, User, DEBUG) ->
    $scope.event = event
    $scope.timeContainer = TimeContainer.fromEventDates(event.dates)

    $scope.participants = []

    for participantObject in $scope.event.participants ? []
      participant = new User(participantObject)
      participant.eventToken = $scope.event.token
      participant.timeContainer = TimeContainer.fromEventDates($scope.event.dates, participant.availabilities)
      $scope.participants.push participant

    $scope.selectedUser = null
    $scope.saving = false
    $scope.errors = {}

    $scope.availabilityContainer = new AvailabilityContainer($scope.event.participants, $scope.timeContainer)

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
      $scope.dialog = createDialog $scope, 'partials/desktop/events/availabilities-modal.html'
      $scope.dialog.setOnClose () => $scope.errors = {}

    $scope.saveAvailabities = ->
      $scope.saving = true
      $scope.user.availabilities = $scope.timeEditContainer.toEventDates($scope.user.isNew())
      if DEBUG
        $scope.dialog.close()
      else
        $scope.user.save().then (savedUser) ->
          $scope.errors.wrongPassword = false
          savedUser.token = $scope.event.token
          savedUser.timeContainer = TimeContainer.fromEventDates($scope.event.dates, savedUser.availabilities)
          $scope.participants.push savedUser unless savedUser in $scope.participants
          $scope.dialog.close()
          $scope.saving = false
        , (response) ->
          $scope.saving = false
          $scope.user.password = ''
          $scope.errors.wrongPassword = true if response.status == 403
